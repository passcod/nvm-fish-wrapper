# NVM fish wrapper

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
iojs-v1.1.0 is already installed.
Now using io.js v1.1.0

~> node -v
v1.1.0

~> nvm use stable
Now using node v0.12.0

~> node -v
v0.12.0
```

## Etc

Made by Félix Saparelli, released in the Public Domain.
