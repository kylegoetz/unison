{-# LANGUAGE LambdaCase #-}
module Unison.Typechecker.Extractor where

import Control.Monad
import Control.Applicative
import Data.Foldable (toList)
import Data.Monoid (First(..), getFirst)
-- import qualified Unison.ABT as ABT
-- import qualified Unison.Type as Type
-- import qualified Unison.TypeVar as TypeVar
import qualified Unison.Typechecker.Context as C
import Unison.Util.Monoid (whenM)

newtype NoteExtractor v loc a =
  NoteExtractor { run :: C.Note v loc -> Maybe a }

newtype PathExtractor v loc a =
  PathExtractor { runPath :: C.PathElement v loc -> Maybe a}

cause :: NoteExtractor v loc (C.Cause v loc)
cause = NoteExtractor $ pure . C.cause

path :: NoteExtractor v loc [C.PathElement v loc]
path = NoteExtractor $ pure . toList . C.path

mismatchedTerm :: NoteExtractor v loc (Maybe (C.Term v loc))
mismatchedTerm = NoteExtractor $ pure . C.innermostErrorTerm

adjacent :: PathExtractor v loc a -> PathExtractor v loc b -> NoteExtractor v loc (a, b)
adjacent (PathExtractor a) (PathExtractor b) =
  NoteExtractor $ go Nothing . toList . C.path where
  go _ [] = Nothing
  go Nothing (h:t) = go (a h) t
  go (Just a) (h:t) = case b h of Nothing -> go Nothing t; Just b -> Just (a,b)

inAndApp :: C.PathElement v loc -> Bool
inAndApp C.InAndApp = True
inAndApp _ = False

inOrApp :: C.PathElement v loc -> Bool
inOrApp C.InOrApp = True
inOrApp _ = False

inIfCond :: C.PathElement v loc -> Bool
inIfCond C.InIfCond = True
inIfCond _ = False

inIfBody :: C.PathElement v loc -> Maybe loc
inIfBody (C.InIfBody loc) = Just loc
inIfBody _ = Nothing

-- inIfBody :: NoteExtractor v loc loc
-- inIfBody = do
--   (_, ()) <- adjacent inSynthesizeApp (fromPredicate inIfBody0)
--   NoteExtractor $ \_ ->
--     case t of
--       Type.Arrow' _i@(ABT.Var' vi) _o ->
--         Just (TypeVar.underlying vi, ABT.annotation e)
--       _ -> Nothing


inSynthesizeApp :: PathExtractor v loc (C.Type v loc, C.Term v loc)
inSynthesizeApp = PathExtractor $ \case
  C.InSynthesizeApp t e -> Just (t,e)
  _ -> Nothing

fromPredicate :: (C.PathElement v loc -> Bool) -> PathExtractor v loc ()
fromPredicate e = PathExtractor (\p -> whenM (e p) (pure ()))

matchAny :: (C.PathElement v loc -> Bool) -> C.Note v loc -> Bool
matchAny p = any p . toList . C.path

matchMaybe :: (C.PathElement v loc -> Maybe a) -> C.Note v loc -> Maybe a
matchMaybe p = getFirst . mconcat . fmap (First . p) . toList . C.path

-- App
-- = And
-- | Or
-- | IfCond
-- | Vector v
-- | Else v
-- | Match v
-- | Handle v

instance Functor (PathExtractor v loc) where
  fmap = liftM

instance Applicative (PathExtractor v loc) where
  (<*>) = ap
  pure = return

instance Monad (PathExtractor v loc) where
  fail _s = empty
  return a = PathExtractor (\_ -> Just a)
  PathExtractor r >>= f = PathExtractor go
    where
      go path = case r path of
        Nothing -> Nothing
        Just a -> runPath (f a) path

instance Alternative (PathExtractor v loc) where
  empty = mzero
  (<|>) = mplus

instance MonadPlus (PathExtractor v loc) where
  mzero = PathExtractor (\_ -> Nothing)
  mplus (PathExtractor f1) (PathExtractor f2) =
    PathExtractor (\note -> f1 note `mplus` f2 note)

instance Functor (NoteExtractor v loc) where
  fmap = liftM

instance Applicative (NoteExtractor v loc) where
  (<*>) = ap
  pure = return

instance Monad (NoteExtractor v loc) where
  fail _s = empty
  return a = NoteExtractor (\_ -> Just a)
  NoteExtractor r >>= f = NoteExtractor go
    where
      go note = case r note of
        Nothing -> Nothing
        Just a -> run (f a) note


instance Alternative (NoteExtractor v loc) where
  empty = mzero
  (<|>) = mplus

instance MonadPlus (NoteExtractor v loc) where
  mzero = NoteExtractor (\_ -> Nothing)
  mplus (NoteExtractor f1) (NoteExtractor f2) =
    NoteExtractor (\note -> f1 note `mplus` f2 note)
