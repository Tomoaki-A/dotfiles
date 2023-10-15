# Settings

- zsh
- VSCode
- Neovim

# zsh

## example

```
~/zshrc

# base
source ~/dotfiles/zsh/base.zsh

# git
source ~/dotfiles/zsh/git-alias.zsh

# pacage manager
source ~/dotfiles/zsh/package-manager.zsh

# util
source ~/dotfiles/zsh/util.zsh
```

# VSCode

## install extensions

```
cd vscode
sh install_extensions.sh
```

## update extensions

```
code-insiders --list-extensions > vscode/extensions
```
