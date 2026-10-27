# Homebrew tap

Homebrew packages maintained by Leslie Russell.

## Install dunk

```sh
brew install lesliesrussell/tap/dunk
dunk
```

[dunk](https://github.com/lesliesrussell/dunk) is a Mason-inspired terminal UI for Homebrew.

```sh
brew update
brew upgrade lesliesrussell/tap/dunk
brew uninstall dunk
```

## Maintenance

Submit formula changes through pull requests. The Homebrew test-bot workflow audits the tap, builds and tests changed formulae on macOS and Linux, and uploads bottles as workflow artifacts. After reviewing a green PR, run the `brew pr-pull` workflow with its PR number and exact reviewed head SHA to merge and publish bottles. This explicitly dispatched workflow has write permissions; routine validation has read-only permissions.

After publishing, dispatch `verify-install.yml` to install the public bottles and test the linked executable on clean macOS and Linux runners. This workflow does not publish or alter the tap.

Source archives and their SHA-256 checksums come from immutable [dunk releases](https://github.com/lesliesrussell/dunk/releases). Do not replace published release assets. Platforms without a matching bottle build from source using the formula's Rust build dependency.
