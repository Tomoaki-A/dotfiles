# dotfilesの設定手順

## dotfilesのクローン
rootディレクトリにクローンする。

```
git clone https://github.com/Tomoaki-A/dotfiles.git
```

## シンボリックリンクの設定

### neovim

```
ln -f -n -s ~/dotfiles/nvim ~/.config
```

### tmux

```
ln -s ~/dotfiles/tmux/tmux.config ~/.tmux.conf
```

### lazygit

```
ln -f -n -s ~/dotfiles/lazygit ~/.config
```


### textlint

```
ln -f -n -s ~/dotfiles/textlint/.textlintrc  ~/.textlintrc
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
```

## GitHub Copilotの設定
GitHubアカウントにログインした状態で下記のコマンドを実行する。
```
:Copilot setup
```
