# Project Starter Template

このテンプレートは、開発プロジェクトをAIコーディングエージェントと立ち上げ、そのまま実装リポジトリへ育てていくための `docs-first` な土台です。
最初から完成済みのアプリ実装を含むものではなく、要件・仕様・運用ルールを先に固めたうえで、必要な実装へ進むことを目的とします。
要件整理から実装着手までをAIエージェント中心で進めたいケース向けのテンプレートです。

## Overview
- 新規の開発プロジェクトを、要件整理から素早く始めたい
- 仕様や非目的を先に明文化して、実装時の迷いを減らしたい
- AIエージェント中心で初回セットアップと文書具体化を進めたい
- Webアプリ、CLI、ライブラリ、社内ツールなどに流用したい

## What This Repository Provides
- 初回要件整理のためのブリーフ
- コア文書のひな形
- エージェントが先に読むための `docs/policy-index.yaml`
- 可変なプロジェクト基本情報を置く `docs/project-metadata.yaml`
- 実装前に前提・対象範囲・非目的を固めるための導線
- テンプレート構成を説明し、コピー後は実装構造に合わせて更新する `ARCHITECTURE.md`
- 重要な設計判断を残すための ADR テンプレート

## Getting Started
1. このリポジトリを新規プロジェクト用にコピーする
2. `docs/initial-brief.md` を粗く埋める
3. `docs/project-metadata.yaml` の基本項目を埋める
4. AIエージェントに、このリポジトリを読ませたうえでコア文書を具体化させる
5. 文書が固まったら、必要な実装や技術スタックの初期化に進む
6. 実装を始めたら、`README.md`、`docs/project-spec.md`、`ARCHITECTURE.md` を実態に合わせて更新し続ける

## Repository Layout
- `README.md` : このテンプレートの使い方
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
- `AGENTS.md` は短い入口とし、`CLAUDE.md`, `GEMINI.md` などの各AI向けファイルは `AGENTS.md` を参照する連携窓口として扱う。
- 詳細な運用ルールは `README.md` に重ねず、`docs/policy-index.yaml` と関連文書に置く。
- repo固有の繰り返しworkflowは `.agents/skills/` に置き、常時効かせたい短いルールは `AGENTS.md` に残す。

## Recommended Optional Integrations
- 汎用テンプレートの段階では、実装依存の強い拡張を最初から組み込まず、必要性が高いものだけを後から有効化する。
- 候補一覧と既定ステータスは `docs/policy-index.yaml` の `policy.integration_catalog` を参照する。
- 補足説明や判断材料は `docs/integrations/` を参照する。
- repo内skillを追加すべき条件は `docs/integrations/skills.md` を参照する。

## Maintenance Notes
- 技術固有メモや実装コマンドは、採用スタック決定後に必要な分だけ追加する
- `ARCHITECTURE.md` はこのテンプレートの構成を説明し、コピー後は現在のコード構造に合わせて更新する
- `docs/policy-index.yaml` は参照ハブ、`docs/project-metadata.yaml` は短い事実、理由や制約は Markdown に分ける

## License / Publication Policy
このテンプレートのライセンスは現時点では未定義です。
公開、再配布、社外利用を行う前に、`LICENSE` の追加または利用範囲の明記を行ってください。

## Contributing
改善方針は [CONTRIBUTING.md](./CONTRIBUTING.md) を参照してください。
