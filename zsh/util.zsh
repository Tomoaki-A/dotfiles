alias v='nvim .'
alias lint='eslint --fix'

alias cg="node ~/template_file_creator/dist/index.js"

alias t="tmux a"

tsr() {
  tmux swap-window -t +1
}
tsl() {
  tmux swap-window -t -1
}
alias c='claude'

# 雑誌: docs/agent の日本語ドキュメント雛形を一括生成
llmdoc() {
  emulate -L zsh
  setopt local_options nounset pipefail

  # 生成先（デフォルト: カレント配下の docs/agent）
  local root="${1:-docs/agent}"
  local rules_dir="$root/rules"
  local repo_root
  repo_root="$(git -C "${PWD:A}" rev-parse --show-toplevel 2>/dev/null)"
  local template_root=""
  if [[ -d "${HOME}/dotfiles/agent" ]]; then
    template_root="${HOME}/dotfiles/agent"
  elif [[ -n "$repo_root" && -d "$repo_root/agent" ]]; then
    template_root="$repo_root/agent"
  else
    echo "missing template root: ${HOME}/dotfiles/agent or \$repo_root/agent"
    return 1
  fi

  /bin/mkdir -p "$rules_dir"

  _mkfile_from_template() {
    local path="$1"
    local template_rel="$2"
    local src="$template_root/$template_rel"

    if [[ ! -e "$src" ]]; then
      echo "missing template: $src"
      return 1
    fi

    if [[ -e "$path" ]]; then
      echo "skip: $path (already exists)"
      return 0
    fi

    /bin/mkdir -p "$(/usr/bin/dirname "$path")"
    /bin/cp "$src" "$path"
    echo "create: $path"
  }

# --- Agent Docs ---
  _mkfile_from_template "$root/BASE.md" "BASE.md"
  _mkfile_from_template "$rules_dir/coding.md" "rules/coding.md"
  _mkfile_from_template "$rules_dir/naming.md" "rules/naming.md"
  _mkfile_from_template "$rules_dir/structure.md" "rules/structure.md"
  _mkfile_from_template "$root/INDEX.md" "INDEX.md"

# --- Entrypoints ---
# Claude Code: import で INDEX を読む
  _mkfile_from_template "CLAUDE.md" "CLAUDE.md"
  _mkfile_from_template "AGENTS.md" "AGENTS.md"
  echo "done: initialized $root (Japanese docs)"
}
