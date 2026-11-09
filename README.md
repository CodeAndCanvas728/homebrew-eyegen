# homebrew-eyegen

The Homebrew formula for [EyeGen](https://github.com/CodeAndCanvas728/eyegen-playground) —
local image generation on Apple Silicon.

## The formula

The formula is pinned to the release tarball and its checksum — currently
[v0.6.0](https://github.com/CodeAndCanvas728/eyegen-playground/releases/tag/v0.6.0).
A Homebrew formula without a checksum is not a formula: the checksum is of the
tarball the release publishes, and there is nothing to check against until there
is a release.

```sh
brew tap CodeAndCanvas728/eyegen
brew install eyegen
```

The formula puts the CLI in a virtual environment in `~/.local/share/eyegen/venv`,
not in the Cellar, so an upgrade does not take the downloaded backends with it.
The GUI is started with the venv Python: `~/.local/share/eyegen/venv/bin/python`
plus the `gui.py` in the formula's libexec.

## Keeping the backends current

The backends are Python packages, and a new model arrives when one of them is
released. To see what is out there and to install it:

```sh
eyegen update-backends
eyegen update-backends --apply
```
