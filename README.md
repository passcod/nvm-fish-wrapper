# NVM fish wrapper

[![GitHub tag](https://img.shields.io/github/tag/passcod/nvm-fish-wrapper.svg?style=flat-square)](https://github.com/passcod/nvm-fish-wrapper)[![License](https://img.shields.io/badge/license-CC0--1.0-blue.svg?style=flat-square)](https://creativecommons.org/publicdomain/zero/1.0/)[![Code of Conduct](https://img.shields.io/badge/contributor-covenant-123456.svg?style=flat-square)](http://contributor-covenant.org/version/1/1/0/)

A heads-up that [someone](https://github.com/edc) has gone and created a
generic fish wrapper for bash utilities, which probably works much better
than this. It's called [bass](https://github.com/edc/bass) and it's everything
I wanted to do with this project, but done right. I think that's the end of
nvm-fish-wrapper. It's been a good ride! [Thank you all](https://github.com/passcod/nvm-fish-wrapper/commit/69198)
and go have wonderful further adventures with fish, Node.js, and nvm!

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

_NVM wrapper for the fish shell._

> All nvm really does to the shell is modify `$PATH`, `$MANPATH`, and a bunch of `$NVM_*` vars. No binstubs afaics.
— https://twitter.com/passcod/status/563948458382331905

> So creating a fish wrapper for it is really simple and will work forever. Why did people do anything else. Github incoming.
— https://twitter.com/passcod/status/563948749395742721

## Installing

You need bash, fish, git, grep, cut, env, mktemp, and test. Unless you have a
weird environment, the last five should be there already. If you don't have
fish then I'm not sure what you're doing here. Git is required for installing
and updating, but you could conceivably copy things in place, whatever. Bash
is required for running, but you'll never need to touch it.

Start by installing [nvm](https://github.com/creationix/nvm) the manual way:

```bash
~> git clone https://github.com/creationix/nvm.git ~/.nvm
~> cd ~/.nvm
~/.nvm> git checkout (git describe --abbrev=0 --tags)
```

If you're on OS X, you can also install nvm using [Homebrew](http://brew.sh):

```bash
~> brew install nvm
~> mkdir ~/.nvm
~> ln -s (brew --prefix nvm)/nvm.sh ~/.nvm/nvm.sh
```

You'll need to add `set -x NVM_DIR ~/.nvm` before sourcing nvm.fish (below) for the
wrapper to work with the brew-installed nvm [[1]].

__Note__: I can't test on OS X, so there are [several open bugs][OSX] at the moment
I cannot address by myself. These bugs seem to only be Homebrew-related, so if you
don't use Homebrew or don't have Homebrew coreutils or didn't install nvm using
Homebrew or some combination of the three, chances are pretty good that it works!

[1]: https://github.com/passcod/nvm-fish-wrapper/issues/8#issuecomment-94372226
[OSX]: https://github.com/passcod/nvm-fish-wrapper/labels/OS%20X

You don't need to source anything or add stuff to `.bashrc`.

Then install the wrapper:

```bash
~> cd ~/.config/fish
~/.c/fish> git clone git://github.com/passcod/nvm-fish-wrapper.git nvm-wrapper
```

Finally edit your `config.fish` and add this line:

```bash
source ~/.config/fish/nvm-wrapper/nvm.fish
```

And reload your shells.

## Using

Just use `nvm` as you would in other shells, e.g.

```bash
~> nvm install iojs
################################################### 100.0%
WARNING: checksums are currently disabled for io.js
Now using io.js v2.3.1

~> node -v
v2.3.1

~> nvm use stable
Now using node v0.12.5

~> node -v
v0.12.5
```

## Etc

Made by Félix Saparelli, released in the Public Domain (or CC0-1.0 if Public
Domain dedications are disallowed or limited in your jurisdiction).

Also made possible by the [contributors] and the [many more][stargazers] [people] using it.

[contributors]: https://github.com/passcod/nvm-fish-wrapper/graphs/contributors
[stargazers]: https://github.com/passcod/nvm-fish-wrapper/stargazers
[people]: https://twitter.com/wraithgar/status/588382384925450240
