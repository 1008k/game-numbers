# AGENTS.md

このファイルはエージェント向けの短い入口です。最初に `docs/policy-index.yaml` を読み、そこから参照先と優先順位を解決してください。判断理由、例外、具体例だけを必要に応じて各 Markdown 文書で確認します。

<!-- CODEX向けの設定 https://developers.openai.com/codex/memories  -->
 [features]
memories = true

<!--
エージェント別の補足メモ:
- `Codex` は上記の `[features]` を解釈します。
- `Claude Code` は `AGENTS.md` 内の同等フラグを持たず、`CLAUDE.md` と `.claude/settings.json` を使います。
- `Gemini CLI` も `AGENTS.md` 内の同等フラグを持たず、`GEMINI.md` と `.gemini/settings.json` を使います。
- `Cursor` は root の `AGENTS.md` をシンプルな agent instructions として読めます。より強いネイティブ運用は `.cursor/rules` です。
- `Windsurf` は `AGENTS.md` を標準で自動検出し、配置ディレクトリに応じてスコープ適用します。
- このリポジトリでは `CLAUDE.md` と `GEMINI.md` から `AGENTS.md` を参照する構成にします。
-->

## 読み順
- 1. `docs/policy-index.yaml`
- 2. `docs/project-metadata.yaml`
- 3. `docs/project-spec.md`
- 4. `docs/rules-coding.md`
- 5. `docs/rules-ux.md`（ユーザー向けUIの設計、実装、レビュー時）
- 6. `DESIGN.md`（ユーザー向けUIの視覚方向、モック、画面パターンを扱う場合）
- 7. `docs/rules-writing.md`
- 8. `README.md`
- 9. `ARCHITECTURE.md`（テンプレート構成確認時、または実装済みの場合）

## 要点
- このリポジトリは `docs-first` テンプレートです。
- まずプロジェクト種別を整理します。
- 可変な基本情報は `docs/project-metadata.yaml` に置きます。
- 実装スタック未確定なら、まず文書を整えます。
- Webアプリの既定具体例は `policy.defaults.example_stacks.web_app` を参照します。
- ユーザー向けUIを扱う場合は `policy.ui_ux` と `docs/rules-ux.md` を参照します。
- UIの見た目やモックを扱う場合は `DESIGN.md` をプロジェクト固有のデザイン方向として参照します。
- 実行コマンドは、実装雛形ができてから `README.md` に確定します。

## 補足
- `docs/policy-index.yaml` が参照ハブ、状態管理、静的チェック、既定判断の置き場です。
- `docs/policy-index.yaml` のキー名と列挙値は、原則として英語で保ちます。
- 各 Markdown 文書は、理由、例外、例示、長文説明の置き場です。
- ルール追加時は、まず `docs/policy-index.yaml` に寄せられるかを確認し、説明が必要な部分だけ Markdown に残します。

## エージェント向け最小ルール
- 詳細は `policy.agent_minimum_rules` を参照します。
- 大きい変更では探索を先に行い、結論と短い計画を先に示します。

## 進め方の既定
- 詳細は `policy.decision_defaults` を参照します。
- 仕様化前は `docs/initial-brief.md` から始め、方向が固まったら拡張候補を棚卸しします。

## 任意の拡張運用
- 詳細は `policy.extension_policy` と `policy.integration_catalog` を参照します。
- 境界がある操作では、明示確認や専用手順を維持します。

## トークン効率
- 詳細は `policy.token_efficiency` を参照します。
- 品質を落とさず、正本から読み、必要な分だけ探索を広げます。
