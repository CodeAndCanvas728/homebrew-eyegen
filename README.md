# homebrew-eyegen

The Homebrew formula for [EyeGen](https://github.com/CodeAndCanvas728/eyegen-playground) —
local image generation on Apple Silicon.

## Install

```sh
brew tap CodeAndCanvas728/eyegen
brew install eyegen
```

## Where the formula comes from

The formula lives in the EyeGen repository, at `homebrew/eyegen.rb`, and is copied
here at each release — the version, the tag and the checksums move together.

## Keeping the backends current

The backends are Python packages, and a new model arrives when one of them is
released. To see what is out there and to install it:

```sh
eyegen update-backends
eyegen update-backends --apply
```
