---
title: Software Foundations on Spacemacs
date: 2017-08-20 12:55:18+1000
tags: Coq
---

## Install Coq

```shell-session
$ brew install coq
```

## Install Proof General

- https://proofgeneral.github.io/
- https://github.com/ProofGeneral/PG

```shell-session
$ cd ~/.emacs.d/private/local
$ git clone git@github.com:ProofGeneral/PG.git
$ cd PG
$ make
```

Executing `make` here caused issues for me. I'm using emacs-mac version of emacs
on macOS.

## Install Coq layer

- https://github.com/olivierverdier/spacemacs-coq
- https://github.com/mbrcknl/spacemacs-coq

This will bring in the company-coq package too.

https://github.com/cpitclaudel/company-coq
