# Project Starter Template

このテンプレートは、開発プロジェクトをAIコーディングエージェントと立ち上げるための `docs-first` な土台です。
最初から完成済みのアプリ実装を含むものではなく、要件・仕様・運用ルールを先に固めることを目的とします。
要件整理からAIエージェントと進めたい人向けのテンプレートです。

## Overview
- 新規の開発プロジェクトを、要件整理から素早く始めたい
- 仕様や非目的を先に明文化して、実装時の迷いを減らしたい
- AIエージェントに初回セットアップを任せたいが、判断基準は人間が握りたい
- Webアプリ、CLI、ライブラリ、社内ツールなどに流用したい

## What This Repository Provides
- 初回要件整理のためのブリーフ
- README、仕様、実装ルール、エージェント向け指示のひな形
- 実装前に前提・対象範囲・非目的を固めるための導線
- 実装が進んだ後に構造理解を補助する `ARCHITECTURE.md` のひな形
- 重要な設計判断を残すための ADR テンプレート

## Getting Started
1. このリポジトリを新規プロジェクト用にコピーする
2. `docs/initial-brief.md` を粗く埋める
3. AIエージェントに、このリポジトリを読ませたうえで `README.md`、`docs/project-spec.md`、`AGENTS.md`、`docs/rules-coding.md` を具体化させる
4. 文書が固まってから、必要な実装や技術スタックの初期化に進む

## Repository Layout
- `README.md` : このテンプレートの使い方
- `ARCHITECTURE.md` : 実装が進んだ後の構造理解を補助する文書（任意）
- `docs/initial-brief.md` : 初回要件整理のための簡易ブリーフ
- `docs/project-spec.md` : 仕様と受け入れ条件のひな形
- `docs/rules-coding.md` : 人間向けの実装判断ルール
- `docs/adr/` : 重要な設計判断を記録するテンプレート（任意）
- `AGENTS.md` : AI エージェント向けの補助文書
- `CONTRIBUTING.md` : 変更提案時の補助文書（任意）
- `CHANGELOG.md` : 重要な変更履歴（任意）

## Default Approach
- 想定対象はソフトウェア開発プロジェクト全般
- まずプロジェクト種別を明確にする
- 技術スタック未確定の段階では、文書整備を優先する
- 実装開始時の既定案は、要件に最も近い最小構成を選ぶ
- Webアプリとして始める場合の例のひとつは `Bun + Vite + TypeScript`

## AI Agent Workflow
- 実装や文書更新を始める前に、`docs/initial-brief.md` の不足事項と前提を整理する。
- 変更が複数ファイルにまたがる、または要件が曖昧な場合は、先に探索と短い計画を行ってから実装する。
- 受け入れ条件や完了条件を書くときは、何をもって完了とみなすかだけでなく、どう確認するかも合わせて明記する。
- AIエージェント向けの常設ルールは短く保ち、詳細は `AGENTS.md`、`docs/project-spec.md`、`docs/rules-coding.md` に集約する。
- Claude Code を使う場合は `CLAUDE.md` を入口として扱い、この `README.md` と関連文書を参照させる。

## Optional Agent Extensions
- MCP、フック、サブエージェント、非対話モード、自動化などの拡張機能は、対応しているエージェントで必要性がある場合に活用を検討する。
- これらの拡張は既定要件ではなく任意運用とし、採用する場合は目的、影響範囲、失敗時の扱いを文書化する。
- 外部通信、権限追加、バックグラウンド実行、継続タスク化を伴う場合は、特に必要性と運用責任を明記する。

## Maintenance Notes
- 仕様と実装がぶつかったら、先に `docs/project-spec.md` と `docs/rules-coding.md` のどちらを更新すべきか整理する
- 技術固有メモは必要になってから追加し、最初から文書を増やしすぎない
- 実装コマンドは、採用スタックが決まってから `README.md` と `AGENTS.md` に確定させる
- 公開用の成果物が必要な場合は、ローカル生成物ではなく CI で作成・配布する
- `ARCHITECTURE.md` は、仕様ではなく現在のコード構造を説明する文書として使う
- 重要な設計判断の理由は、必要に応じて `docs/adr/` に分離して残す

## Contributing
改善方針は [CONTRIBUTING.md](./CONTRIBUTING.md) を参照してください。
