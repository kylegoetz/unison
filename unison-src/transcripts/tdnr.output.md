TDNR selects local term (in file) that typechecks over local term (in file) that doesn't.

``` unison
good.foo = 17
bad.foo = "bar"
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo  : Text
      good.foo : Nat
      thing    : Nat

```
TDNR selects local term (in file) that typechecks over local term (in namespace) that doesn't.

``` unison
bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo : Text

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    bad.foo : Text

```
``` unison
good.foo = 17
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      good.foo : Nat
      thing    : Nat

```
TDNR selects local term (in file) that typechecks over local term (shadowing namespace) that doesn't.

``` unison
bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo : Text

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    bad.foo : Text

```
``` unison
good.foo = 17
bad.foo = "baz"
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      good.foo : Nat
      thing    : Nat
    
    ⍟ These names already exist. You can `update` them to your
      new definition:
    
      bad.foo : Text

```
TDNR selects local term (in namespace) that typechecks over local term (in file) that doesn't.

``` unison
good.foo = 17
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      good.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    good.foo : Nat

```
``` unison
bad.foo = "bar"
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo : Text
      thing   : Nat

```
TDNR selects local term (in namespace) that typechecks over local term (in namespace) that doesn't.

``` unison
good.foo = 17
bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo  : Text
      good.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    bad.foo  : Text
    good.foo : Nat

```
``` unison
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat

```
TDNR selects local term (in namespace) that typechecks over local term (shadowing namespace) that doesn't.

``` unison
good.foo = 17
bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo  : Text
      good.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    bad.foo  : Text
    good.foo : Nat

```
``` unison
bad.foo = "baz"
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat
    
    ⍟ These names already exist. You can `update` them to your
      new definition:
    
      bad.foo : Text

```
TDNR selects local term (shadowing namespace) that typechecks over local term (in file) that doesn't.

``` unison
good.foo = 17
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      good.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    good.foo : Nat

```
``` unison
good.foo = 18
bad.foo = "bar"
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo : Text
      thing   : Nat
    
    ⍟ These names already exist. You can `update` them to your
      new definition:
    
      good.foo : Nat

```
TDNR selects local term (shadowing namespace) that typechecks over local term (in namespace) that doesn't.

``` unison
good.foo = 17
bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo  : Text
      good.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    bad.foo  : Text
    good.foo : Nat

```
``` unison
good.foo = 18
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat
    
    ⍟ These names already exist. You can `update` them to your
      new definition:
    
      good.foo : Nat

```
TDNR selects local term (shadowing namespace) that typechecks over local term (shadowing namespace) that doesn't.

``` unison
good.foo = 17
bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo  : Text
      good.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    bad.foo  : Text
    good.foo : Nat

```
``` unison
good.foo = 18
bad.foo = "baz"
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat
    
    ⍟ These names already exist. You can `update` them to your
      new definition:
    
      bad.foo  : Text
      good.foo : Nat

```
\=== start local over direct dep

TDNR selects local term (in file) that typechecks over direct dependency that doesn't.

``` unison
lib.bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      lib.bad.foo : Text

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    lib.bad.foo : Text

```
``` unison
good.foo = 17
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      good.foo : Nat
      thing    : Nat

```
TDNR selects local term (in namespace) that typechecks over direct dependency that doesn't.

``` unison
good.foo = 17
lib.bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      good.foo    : Nat
      lib.bad.foo : Text

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    good.foo    : Nat
    lib.bad.foo : Text

```
``` unison
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat

```
TDNR selects local term (shadowing namespace) that typechecks over direct dependency that doesn't.

``` unison
good.foo = 17
lib.bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      good.foo    : Nat
      lib.bad.foo : Text

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    good.foo    : Nat
    lib.bad.foo : Text

```
``` unison
good.foo = 18
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat
    
    ⍟ These names already exist. You can `update` them to your
      new definition:
    
      good.foo : Nat

```
TDNR not used to select local term (in file) that typechecks over indirect dependency that also typechecks.

``` unison
lib.dep.lib.dep.foo = 217
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      lib.dep.lib.dep.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    lib.dep.lib.dep.foo : Nat

```
``` unison
good.foo = 17
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      good.foo : Nat
      thing    : Nat

```
TDNR not used to select local term (in namespace) that typechecks over indirect dependency that also typechecks.

``` unison
good.foo = 17
lib.dep.lib.dep.foo = 217
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      good.foo            : Nat
      lib.dep.lib.dep.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    good.foo            : Nat
    lib.dep.lib.dep.foo : Nat

```
``` unison
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat

```
TDNR not used to select local term (shadowing namespace) that typechecks over indirect dependency that also typechecks.

``` unison
good.foo = 17
lib.dep.lib.dep.foo = 217
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      good.foo            : Nat
      lib.dep.lib.dep.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    good.foo            : Nat
    lib.dep.lib.dep.foo : Nat

```
``` unison
good.foo = 18
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat
    
    ⍟ These names already exist. You can `update` them to your
      new definition:
    
      good.foo : Nat

```
TDNR selects direct dependency that typechecks over local term (in file) that doesn't.

``` unison
lib.good.foo = 17
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      lib.good.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    lib.good.foo : Nat

```
``` unison
bad.foo = "bar"
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo : Text
      thing   : Nat

```
TDNR selects direct dependency that typechecks over local term (in namespace) that doesn't.

``` unison
lib.good.foo = 17
bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo      : Text
      lib.good.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    bad.foo      : Text
    lib.good.foo : Nat

```
``` unison
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat

```
TDNR selects direct dependency that typechecks over local term (shadowing namespace) that doesn't.

``` unison
lib.good.foo = 17
bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      bad.foo      : Text
      lib.good.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    bad.foo      : Text
    lib.good.foo : Nat

```
``` unison
bad.foo = "baz"
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat
    
    ⍟ These names already exist. You can `update` them to your
      new definition:
    
      bad.foo : Text

```
TDNR selects direct dependency that typechecks over direct dependency that doesn't.

``` unison
lib.good.foo = 17
lib.bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      lib.bad.foo  : Text
      lib.good.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    lib.bad.foo  : Text
    lib.good.foo : Nat

```
``` unison
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat

```
TDNR not used to select direct dependency that typechecks over indirect dependency that also typechecks.

``` unison
lib.good.foo = 17
lib.dep.lib.dep.foo = 217
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      lib.dep.lib.dep.foo : Nat
      lib.good.foo        : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    lib.dep.lib.dep.foo : Nat
    lib.good.foo        : Nat

```
``` unison
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat

```
TDNR selects indirect dependency that typechecks over indirect dependency that doesn't.

``` unison
lib.dep.lib.good.foo = 17
lib.dep.lib.bad.foo = "bar"
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      lib.dep.lib.bad.foo  : Text
      lib.dep.lib.good.foo : Nat

```
``` ucm
scratch/main> add

  ⍟ I've added these definitions:
  
    lib.dep.lib.bad.foo  : Text
    lib.dep.lib.good.foo : Nat

```
``` unison
thing = foo Nat.+ foo
```

``` ucm

  Loading changes detected in scratch.u.

  I found and typechecked these definitions in scratch.u. If you
  do an `add` or `update`, here's how your codebase would
  change:
  
    ⍟ These new definitions are ok to `add`:
    
      thing : Nat

```
