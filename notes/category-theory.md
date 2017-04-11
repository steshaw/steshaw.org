# Category Theory

## Monic / Epic

Related vides from Bartosz Milewski:

- [Category Theory 2.1: Functions, epimorphisms](https://youtu.be/O2lZkr-aAqk?list=PLbgaMIhjbmEnaH_LTkxLI7FMa2HsnawM_)
- [Category Theory 2.2: Monomorphisms, simple types](https://youtu.be/NcT7CGPICzo?list=PLbgaMIhjbmEnaH_LTkxLI7FMa2HsnawM)

In set theory,

- an injective function is a 1-to-1 mapping.
- a surjective function is "onto". i.e. the image of the function covers the
  entire co-domain.

In CT, these notions abstract to:

- injective (function) = monic morphism or monomorphism
- surjective (function) = epic morphism or epimorphism

Since CT cannot refer to the elements of a set, these need to be defined in
terms only of CT concepts: composition and morphisms. The technique is called
"universal property" or "universal construction" because it's necessary to
consider all morphisms in the category.

Definition of monomorphism:
```plain
f is a monomorphism if, f : X → Y such that,
  for all morphisms g1, g2 : Z → X,
    f ∘ g1 = f ∘ g2 => g1 = g2
```

Definition of epimorphism:
```plain
f is an epimorphism if, f : X → Y such that,
  for all morphisms g1, g2 : Y → Z,
    g1 ∘ f = g2 ∘ f => g1 = g2
```

Note: apparently, in CT, isomorphism != monomorphism + epimorphism.
I guess you need something a little stronger than in set theory.


## Preorders / Orders / Partial Orders

- [Category Theory 3.1: Examples of categories, orders, monoids](https://youtu.be/aZjhqkD6k6w?list=PLbgaMIhjbmEnaH_LTkxLI7FMa2HsnawM)

TODO


## Monoids

- [Category Theory 3.1: Examples of categories, orders, monoids](https://youtu.be/aZjhqkD6k6w?list=PLbgaMIhjbmEnaH_LTkxLI7FMa2HsnawM)

TODO
