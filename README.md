# Settings

- zsh
- VSCode
- Neovim

# zsh

## example

```
~/zshrc

# base
source ~/system-settings/zsh/base.zsh

# git
source ~/system-settings/zsh/git-alias.zsh

# pacage manager
source ~/system-settings/zsh/package-manager.zsh

# util
source ~/system-settings/zsh/util.zsh
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
