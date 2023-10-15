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

## 一覧をインストール

```
cd vscode
sh install_extensions.sh
```

## 拡張機能の一覧更新

```
code-insiders --list-extensions > vscode/extensions
```
