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

  mkdir -p "$rules_dir"

  _mkfile_if_absent() {
    local path="$1"
    local content="$2"

    if [[ -e "$path" ]]; then
      echo "skip: $path (already exists)"
      return 0
    fi

    mkdir -p "$(dirname "$path")"
    printf "%s" "$content" > "$path"
    echo "create: $path"
  }

# --- Agent Docs ---
  _mkfile_if_absent "$root/BASE.md" \
"# Agent基本方針（BASE）

## 基本思想
- 正本はdocs/agent/INDEX.md
- ドキュメントは日本語を優先する
"

  _mkfile_if_absent "$rules_dir/coding.md" \
"# コーディング規約

## TypeScript
### 関数
- 関数型プログラミングスタイルで実装する
- 破壊的なメソッドは使用しない
- 関数は小さく、副作用を持たせない
- アロー関数のみを使用する
- pushメソッドは使用しない
- forループは使用しない
- forEachは使用しない
- map/flatMap/reduceを優先的に使用する
- 関数の引数はObjectでまとめることを優先する

### 型定義
- 型定義は \`type\` を使用する
- 配列型は \`Array<T>\` 形式を使う
- 配列型の場合初期値は空配列 \`[]\` を使いOptionalにしない

## Next.js
- App Routerを前提とする
- UIとドメインロジックを分離する

## 一般原則
- SOLID / DRY / KISSを指針として扱う
- ドメイン駆動設計(DDD) を指針として扱う
- クリーンアーキテクチャを指針として扱う
"

  _mkfile_if_absent "$rules_dir/naming.md" \
"# 命名規約

## コード命名
- 意味のある変数名・引数名を使う
- 配列型は \`~List\` サフィックスを付ける（例: UserList）
- オブジェクトの集合は複数形を使う
"

  _mkfile_if_absent "$rules_dir/structure.md" \
"# 構成・構造規約

## ディレクトリ構成
### UIコンポーネント
- ui/
  - Reactコンポーネントを配置
- ui/entity/
  - domainに依存するコンポーネントを配置
- ui/parts/
  - 再利用可能な小さなコンポーネントを配置
  - domainに依存しない

### ドメインロジック
- domain/
  - クリーンアーキテクチャのentity層に対応
  - 配下に各概念ごとのディレクトリを作成する
  - ビジネスロジックを配置
  - ドメインモデル（型定義）を配置

### データ
- data/
  - クリーンアーキテクチャのdata層に対応
  - 外部APIやデータベースとのやり取りを担当
  - 配下に各概念ごとのディレクトリを作成する
"

  _mkfile_if_absent "$root/INDEX.md" \
"# AgentドキュメントINDEX

## 読む順番
1. BASE.md
2. rules/*

## ドキュメント構成
- 基本方針: ./BASE.md
- コーディング規約: ./rules/coding.md
- 命名規約: ./rules/naming.md
- 構成規約: ./rules/structure.md

## 追加ルール
- 新しいドキュメントを追加する場合は、必ずこのINDEXを更新する
- INDEXに記載されていないドキュメントは参照禁止
"

# --- Entrypoints ---
# Claude Code: import で INDEX を読む
  _mkfile_if_absent "CLAUDE.md" \
"# Claude Codeエントリポイント

@docs/agent/INDEX.md
"

_mkfile_if_absent "AGENTS.md" \
"# Codexエントリポイント

## 最優先
- まずdocs/agent/INDEX.mdを読む
- 以降の判断はINDEXの優先度ルールに従う（rulesが最優先）
"
  echo "done: initialized $root (Japanese docs)"
}
