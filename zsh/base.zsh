export XDG_CONFIG_HOME="$HOME/.config"

# change directory
alias cdd='cd ~/Desktop'
alias cddot='cd ~/dotfiles'
alias cdp='cd ~/Documents/Projects'

# zsh
alias zupd='source ~/.zshrc'

alias e='exit'

# terminal
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

PROMPT='
%*
%F{magenta}%B%n%b%f@%F{blue}%U%m%u%f[%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f 
%F{yellow}$%f '

autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
   source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -Uz compinit && compinit
fi
