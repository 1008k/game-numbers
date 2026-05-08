# Project Starter Template

このテンプレートは、AIコーディングエージェントと開発プロジェクトを立ち上げ、そのまま実装リポジトリへ育てる `docs-first` の土台です。
完成済みのアプリ実装は含まず、要件・仕様・運用ルールを先に固めてから実装へ進みたいケースを想定しています。

## Overview
- 新規の開発プロジェクトを、要件整理から素早く始めたい
- 仕様や非目的を先に明文化して、実装時の迷いを減らしたい
- AIエージェント中心で初回セットアップと文書具体化を進めたい
- Webアプリ、CLI、ライブラリ、社内ツールなどに流用したい

## What This Repository Provides
- 初回要件整理用ブリーフ
- コア文書のひな形
- AIデザインツールやコーディングエージェント間で持ち運ぶ `DESIGN.md`
- エージェントの先読みに使う `docs/policy-index.yaml`
- 可変なプロジェクト基本情報を置く `docs/project-metadata.yaml`
- 実装前に前提・対象範囲・非目的を固める導線
- テンプレート構成を説明し、コピー後は実装構造に合わせて更新する `ARCHITECTURE.md`
- 重要な設計判断を残す ADR テンプレート

## Getting Started
1. このリポジトリを新規プロジェクト用にコピーする
2. `docs/initial-brief.md` を粗く埋める
3. `docs/project-metadata.yaml` の基本項目を埋める
4. AIエージェントに、このリポジトリを読ませたうえでコア文書を具体化させる
5. 文書が固まったら、必要な実装や技術スタックの初期化に進む
6. 実装を始めたら、`README.md`、`docs/project-spec.md`、`ARCHITECTURE.md` を実態に合わせて更新し続ける

## Repository Layout
- `README.md` : このテンプレートの使い方
- `DESIGN.md` : Stitchなどへ持ち運ぶプロジェクト固有のデザイン方向と画面パターン（任意）
- `ARCHITECTURE.md` : テンプレート構成の説明と、コピー後プロジェクトのコード構造補助文書（任意）
- `.agents/skills/` : repo固有の再利用workflowを置くskillディレクトリ（任意）
- `docs/initial-brief.md` : 初回要件整理の簡易ブリーフ
- `docs/project-metadata.yaml` : 可変な基本情報
- `docs/integrations/` : 拡張導入判断の補助文書
- `docs/project-spec.md` : 要件定義、仕様、スコープ外、受け入れ条件の正本
- `docs/rules-coding.md` : 実装判断の説明
- `docs/rules-ux.md` : ユーザー向けUIの設計、実装、レビュー時の判断基準
- `docs/rules-writing.md` : 文書表記ルール
- `docs/policy-index.yaml` : 参照ハブと静的項目
- `docs/adr/` : 設計判断の記録テンプレート（任意）
- `AGENTS.md` : AIエージェント向け入口
- `CLAUDE.md`, `GEMINI.md` : `AGENTS.md` の互換入口
- `.cursorrules`, `.windsurfrules` : `AGENTS.md` の互換入口（Cursor, Windsurf向け）
- `CONTRIBUTING.md` : 変更提案の補助文書（任意）
- `CHANGELOG.md` : 重要な変更履歴（任意）

## AI Agent Workflow & Extensions
- エージェントは最初に `docs/policy-index.yaml` を読み、参照先、優先順位、状態、既定判断を解決する。
- ユーザー向けUIを扱う場合は、`docs/rules-ux.md` でUXルールを確認し、`DESIGN.md` があれば参照する。
- `AGENTS.md` は短い入口とし、`CLAUDE.md` や `GEMINI.md` などの各AI向けファイルはその参照窓口にする。
- 詳細な運用ルールは `README.md` に重ねず、`docs/policy-index.yaml` と関連文書に置く。
- リポジトリ固有の繰り返しワークフローは `.agents/skills/` に置き、常時適用したい短いルールは `AGENTS.md` に残す。
- Codexへの依頼は、可能なら `Goal / Context / Constraints / Done when` を含める。
- repo固有のCodex設定が必要になったら `.codex/config.toml` を追加し、個人設定は `~/.codex/config.toml` に分ける。
- 自動化は、手動で安定した手順だけを対象にする。手順の定義は skill、実行スケジュールは automation と分けて考える。

## Prompting Tips For Codex
- `Goal`: 何を変えるか、何を作るか
- `Context`: 関係するファイル、文書、エラー、参考実装
- `Constraints`: 守るべき仕様、設計、禁止事項、互換条件
- `Done when`: 完了条件。期待挙動、必要なテスト、確認観点
- 毎回ほぼ同じ依頼文を少しずつ変えるより、固定ルールは `AGENTS.md` に寄せ、タスク固有情報だけを依頼本文に入れる。

## Recommended Optional Integrations
- 汎用テンプレートの段階では、実装依存の強い拡張を最初から組み込まず、必要性が高いものだけを後から有効化する。
- 候補一覧と既定ステータスは `docs/policy-index.yaml` の `policy.integration_catalog` を参照する。
- 補足説明や判断材料は `docs/integrations/` を参照する。
- リポジトリ内skillを追加すべき条件は `docs/integrations/skills.md` を参照する。

## Maintenance Notes
- 技術固有メモや実装コマンドは、採用スタック決定後に必要な分だけ追加する
- `ARCHITECTURE.md` はこのテンプレートの構成を説明し、コピー後は現在のコード構造に合わせて更新する
- `docs/policy-index.yaml` は参照ハブ、`docs/project-metadata.yaml` は短い事実、理由や制約は Markdown に分ける

## License / Publication Policy
このテンプレートのライセンスは現時点では未定義です。
公開、再配布、社外利用を行う前に、`LICENSE` の追加または利用範囲の明記を行ってください。

## Contributing
改善方針は [CONTRIBUTING.md](./CONTRIBUTING.md) を参照。
