# dotfilesの設定手順

## dotfilesのクローン
rootディレクトリにクローンする。

```
git clone https://github.com/Tomoaki-A/dotfiles.git
```

## brewアプリのインストール

```
brew bundle --file ~/dotfiles/Brewfile
```

## シンボリックリンクの設定

### neovim

```
ln -f -n -s ~/dotfiles/nvim ~/.config
```

### tmux

```
ln -f -n -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
```

### lazygit

```
ln -f -n -s ~/dotfiles/lazygit ~/.config
```


### textlint

```
ln -f -n -s ~/dotfiles/textlint/.textlintrc  ~/.textlintrc
```

## vim-plugのインストール

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### Pluginのインストール

```
:PlugInstall 
```

## zshの設定
zshrcに下記のコードを追加する。

```
# base
source ~/dotfiles/zsh/base.zsh

# git
source ~/dotfiles/zsh/git-alias.zsh

# pacage manager
source ~/dotfiles/zsh/package-manager.zsh

# util
source ~/dotfiles/zsh/util.zsh

```

## aicommitsの設定
OpenAIのAPIキーを設定する。

```
aicommits config set OPENAI_KEY=<your token>
aicommits config set model=gpt-4
```

## GitHub Copilotの設定
GitHubアカウントにログインした状態で下記のコマンドを実行する。
```
:Copilot setup
```

## 参考URL
- [Neovim設定覚書](https://zenn.dev/tomoaki_a/scraps/35262759c75b90)
