# dotfiles セットアップ手順

## 概要
この手順では、`~/dotfiles` を基準として開発環境を再現する。

---

## dotfiles のクローン
root（ホームディレクトリ）にクローンする。

```bash
git clone https://github.com/Tomoaki-A/dotfiles.git ~/dotfiles
```

---

## Homebrew アプリのインストール
Brewfile に定義されたアプリケーションを一括インストールする。

```bash
brew bundle --file ~/dotfiles/Brewfile
```

---

## シンボリックリンクの設定

### config ディレクトリ作成（存在しない場合）

```bash
mkdir -p ~/.config
```

### neovim

```bash
rm -rf ~/.config/nvim
ln -sfn ~/dotfiles/nvim ~/.config/nvim
```

### tmux

```bash
ln -f -n -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
```

### lazygit

```bash
ln -f -n -s ~/dotfiles/lazygit ~/.config/lazygit
```

### textlint

```bash
ln -f -n -s ~/dotfiles/textlint/.textlintrc ~/.textlintrc
```

### alacritty

```bash
ln -sfn ~/dotfiles/alacritty ~/.config/alacritty
```

---

## vim-plug のインストール

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### Plugin のインストール

Neovim 起動後に実行:

```vim
:PlugInstall
```

---

## zsh の設定

`~/.zshrc` に以下を追記する。

```bash
# base
source ~/dotfiles/zsh/base.zsh

# git
source ~/dotfiles/zsh/git-alias.zsh

# package manager
source ~/dotfiles/zsh/package-manager.zsh

# util
source ~/dotfiles/zsh/util.zsh
```

---

## aicommits の設定

OpenAI の API キーを設定する。

```bash
aicommits config set OPENAI_KEY=<your token>
aicommits config set model=gpt-4
```

---

## GitHub Copilot の設定

GitHub アカウントにログインした状態で実行する。

```vim
:Copilot setup
```

---

## Brewfile の更新

```bash
brew bundle dump --force
```

---

## Key 入力感度調整

```bash
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
```

コマンド入力後、システム再起動が必要。

---

## 参考URL

- Neovim設定覚書  
  https://zenn.dev/tomoaki_a/scraps/35262759c75b90


