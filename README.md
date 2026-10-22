# homebrew-eyegen

The Homebrew formula for [EyeGen](https://github.com/CodeAndCanvas728/eyegen-playground) —
local image generation on Apple Silicon.

## The formula

It arrives with the first release. A Homebrew formula without a checksum is not a
formula: the checksum is of the tarball the release publishes, and there is nothing
to check against until there is a release.

```sh
brew tap CodeAndCanvas728/eyegen
brew install eyegen
```

## Keeping the backends current

The backends are Python packages, and a new model arrives when one of them is
released. To see what is out there and to install it:

```sh
eyegen update-backends
eyegen update-backends --apply
```
