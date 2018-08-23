{-# LANGUAGE ScopedTypeVariables #-}

module Unison.Typechecker.TypeError where

import           Control.Applicative ((<|>))
import           Data.Foldable
import           Data.Maybe (fromMaybe, listToMaybe)
import           Debug.Trace
import qualified Unison.ABT as ABT
import qualified Unison.Typechecker.Context as C
import qualified Unison.Typechecker.Extractor as Ex
import           Unison.Var (Var)

data BooleanMismatch = CondMismatch | AndMismatch | OrMismatch | GuardMismatch
data ExistentialMismatch = IfBody | VectorBody | CaseBody

data TypeError v loc
  = Mismatch { foundType    :: C.Type v loc -- overallType1
             , expectedType :: C.Type v loc -- overallType2
             , foundLeaf    :: C.Type v loc -- leaf1
             , expectedLeaf :: C.Type v loc -- leaf2
             , mismatchSite :: loc
             , note         :: C.Note v loc
             }
  | BooleanMismatch { booleanMismatch :: BooleanMismatch
                    , mismatchSite    :: loc
                    , foundType       :: C.Type v loc
                    , note            :: C.Note v loc
                    }
  | ExistentialMismatch { existentialMismatch :: ExistentialMismatch
                        , expectedType        :: C.Type v loc
                        , expectedLoc         :: loc
                        , foundType           :: C.Type v loc
                        , mismatchSite        :: loc
                        , note                :: C.Note v loc
                        }
  | FunctionApplication { f            :: C.Term v loc
                        , argNum       :: Int
                        , expectedType :: C.Type v loc
                        , foundType    :: C.Type v loc
                        , arg          :: C.Term v loc
                        , fVarInfo     :: Maybe (C.Type v loc, [(v, C.Type v loc)])
                        , note         :: C.Note v loc
                        }
  | NotFunctionApplication { f :: C.Term v loc, ft :: C.Type v loc , note :: C.Note v loc }
  | AbilityCheckFailure { ambient                 :: [C.Type v loc]
                        , requested               :: [C.Type v loc]
                        , abilityCheckFailureSite :: loc
                        , note :: C.Note v loc
                        }
  | UnknownType { unknownType :: v
                , typeSite    :: loc
                , note        :: C.Note v loc
                }
  | UnknownTerm { unknownTerm :: v
                , termSite :: loc
                , suggestions :: [C.Suggestion v loc]
                , expectedType :: C.Type v loc
                , note :: C.Note v loc
                }
  | Other (C.Note v loc)

typeErrorFromNote :: forall loc v. (Ord loc, Show loc, Var v) => C.Note v loc -> TypeError v loc
typeErrorFromNote n@(C.Note (C.TypeMismatch ctx) path) =
  let
    pathl = toList path
    subtypes = [ (t1, t2) | C.InSubtype t1 t2 <- pathl ]
    firstSubtype = listToMaybe subtypes
    lastSubtype = if null subtypes then Nothing else Just (last subtypes)
    innermostTerm = C.innermostErrorTerm n
    -- replace any type vars with their solutions before returning
    sub t = C.apply ctx t
  in case (firstSubtype, lastSubtype, innermostTerm) of
    (Just (foundLeaf, expectedLeaf),
     Just (foundType, expectedType),
     Just mismatchSite) ->
      let mismatchLoc = ABT.annotation mismatchSite
          booleanMismatch
            :: Monad m => m a -> BooleanMismatch -> m (TypeError v loc)
          booleanMismatch x y = x >>
            (pure $ BooleanMismatch y (ABT.annotation mismatchSite) foundType n)
          existentialMismatch
            :: Monad m => m loc -> ExistentialMismatch -> m (TypeError v loc)
          existentialMismatch x y = x >>= \expectedLoc -> pure $
            ExistentialMismatch y expectedType expectedLoc foundType mismatchLoc n
          and,or,cond,guard,ifBody,vectorBody,caseBody,all,functionArg
            :: Ex.NoteExtractor v loc (TypeError v loc)
          and = booleanMismatch Ex.inAndApp AndMismatch
          or = booleanMismatch Ex.inOrApp OrMismatch
          cond = booleanMismatch Ex.inIfCond CondMismatch
          guard = booleanMismatch Ex.inMatchCaseGuard GuardMismatch
          ifBody = existentialMismatch Ex.inIfBody IfBody
          vectorBody = existentialMismatch Ex.inVectorApp VectorBody
          caseBody = existentialMismatch Ex.inMatchCaseBody CaseBody
          functionArg = do
            (f, index, expectedType, foundType, arg, fPoly) <- Ex.inApp
            pure $ FunctionApplication f index expectedType foundType arg fPoly n

          all = and <|> or <|> cond <|> guard <|>
                ifBody <|> vectorBody <|> caseBody <|> functionArg

      in case Ex.run all n of
        Just msg -> msg
        Nothing ->
          Mismatch (sub foundType) (sub expectedType)
                   (sub foundLeaf) (sub expectedLeaf)
                   (ABT.annotation mismatchSite)
                   n
    (Nothing, Nothing, Just mismatchSite) ->
      let --mismatchLoc = ABT.annotation mismatchSite
          appyingNonFunction = do
            (f, ft) <- Ex.applyingNonFunction
            pure $ NotFunctionApplication f ft n
      in case Ex.run appyingNonFunction n of
        Just msg -> msg
        Nothing -> trace ("other debug:\n"
                          ++ "  mismatchSite: " ++ show mismatchSite ++ "\n") $
                   Other n
    _ ->
      trace ("other debug:\n"
              ++ "   firstSubtype: " ++ show firstSubtype ++ "\n"
              ++ "    lastSubtype: " ++ show lastSubtype ++ "\n"
              ++ "  innermostTerm: " ++ show innermostTerm ++ "\n") $
      Other n
typeErrorFromNote n@(C.Note (C.AbilityCheckFailure amb req _) _) =
  let go :: C.Term v loc -> TypeError v loc
      go e = AbilityCheckFailure amb req (ABT.annotation e) n
  in fromMaybe (Other n) $ go <$> C.innermostErrorTerm n
typeErrorFromNote n@(C.Note (C.UnknownSymbol loc v) _) =
  UnknownType v loc n
typeErrorFromNote n@(C.Note (C.UnknownTerm loc v suggs typ) _) =
  UnknownTerm v loc suggs typ n
typeErrorFromNote n@(C.Note _ _) = Other n
