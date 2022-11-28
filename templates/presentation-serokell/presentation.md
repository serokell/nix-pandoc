---
title: Cool Presentation
author: You
institution: Serokell
date: now
aspectratio: 169
mainfont: Ubuntu
monofont: Ubuntu Mono
sansfont: Oswald
theme: Serokell
header-includes:
  - \usepackage[outputdir=_output]{minted}
  - \usemintedstyle{native}
---

# This is what sections look like

## This is what slide titles look like

### This is for slide subsections

::: notes
This is what speaker notes look like
:::

```nix
{
  this = "some syntax-highlighted Nix code";
}
```

### This will be highlighted as a shell session:

    $ :(){ :|:& };:

### And this is Haskell:

```haskell
main = print "Monads are just monoids in the category of endofunctors"
```

## This is another slide

::: columns

:::: column
### Column 1
You can have
::::

:::: column
### Column 2
Multiple columns!
::::

:::