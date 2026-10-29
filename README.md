# homebrew-ush

The Homebrew tap for [ush](https://github.com/gregoryyy/ushell), the `//` shell for zsh: ask in
plain language, and ush proposes the shell command that answers it, on your command line.

```sh
brew tap gregoryyy/ush
brew trust gregoryyy/ush      # Homebrew loads formulas from third-party taps only once trusted
brew install ush
```

The formula builds `ush` from the tagged source of a release with Go; it has no other
dependencies. Then add the line `brew info ush` prints to `~/.zshrc`, open a new terminal, and run
`ush ai configure`. `man ush` has the manual.

A Homebrew prefix is owned by your user, so don't use this `ush` with `sudo`: for that, install a
root-owned copy from a release archive ([admin guide](https://github.com/gregoryyy/ushell/blob/main/ush/docs/ADMIN.md)).

`Formula/ush.rb` is generated for each release by `ush/go/scripts/formula.sh` in the ushell
repository. Issues go there too.

Licence: MIT.
