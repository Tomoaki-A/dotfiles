alias v='nvim .'
alias lint='eslint --fix'

alias md='cd ~/Documents/Projects/md-studio && pnpm dev'

alias cg="node ~/template_file_creator/dist/index.js"

alias t="tmux a"
alias tupd="tmux source-file ~/.tmux.conf"
alias trs="tmux rename-session"


tsr() {
  tmux swap-window -t +1
}
tsl() {
  tmux swap-window -t -1
}
alias c='claude'

# 雑誌: docs/agent の日本語ドキュメント雛形を一括生成
ldocinit() {
  emulate -L zsh
  setopt local_options nounset pipefail

  # 生成先（デフォルト: カレント配下の docs/agent）
  local root="${1:-docs/agent}"
  local rules_dir="$root/rules"
  local projects_dir="$root/projects"
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

  /bin/mkdir -p "$rules_dir" "$projects_dir"

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

# 既存ドキュメントを差分追加で更新（削除なし）
ldocupdate() {
  emulate -L zsh
  setopt local_options nounset pipefail

  # 更新先（デフォルト: カレント配下の docs/agent）
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

  _append_missing_lines() {
    local path="$1"
    local src="$2"
    local tmp addtmp
    tmp="$(/usr/bin/mktemp)"
    addtmp="$(/usr/bin/mktemp)"

    /bin/cp "$path" "$tmp"

    /usr/bin/awk 'NR==FNR { seen[$0]=1; next } { if ($0 != "" && !seen[$0]) print $0 }' \
      "$path" "$src" > "$addtmp"

    if [[ -s "$addtmp" ]]; then
      if [[ -s "$tmp" && "$(/usr/bin/tail -c 1 "$tmp")" != $'\n' ]]; then
        printf '\n' >> "$tmp"
      fi
      /bin/cat "$addtmp" >> "$tmp"
    fi

    if ! /usr/bin/cmp -s "$path" "$tmp"; then
      /bin/mv "$tmp" "$path"
      /bin/rm -f "$addtmp"
      echo "update: $path (append missing lines)"
    else
      /bin/rm -f "$tmp" "$addtmp"
      echo "skip: $path (already up to date)"
    fi
  }

  _merge_from_template() {
    local path="$1"
    local template_rel="$2"
    local src="$template_root/$template_rel"

    if [[ ! -e "$src" ]]; then
      echo "missing template: $src"
      return 1
    fi

    if [[ ! -e "$path" ]]; then
      /bin/mkdir -p "$(/usr/bin/dirname "$path")"
      /bin/cp "$src" "$path"
      echo "create: $path"
      return 0
    fi

    _append_missing_lines "$path" "$src"
  }

# --- Agent Docs (no projects) ---
  _merge_from_template "$root/BASE.md" "BASE.md"
  _merge_from_template "$rules_dir/coding.md" "rules/coding.md"
  _merge_from_template "$rules_dir/naming.md" "rules/naming.md"
  _merge_from_template "$rules_dir/structure.md" "rules/structure.md"
  _merge_from_template "$root/INDEX.md" "INDEX.md"

# --- Entrypoints ---
# Claude Code: import で INDEX を読む
  _merge_from_template "CLAUDE.md" "CLAUDE.md"
  _merge_from_template "AGENTS.md" "AGENTS.md"
  echo "done: updated $root (append-only)"
}
