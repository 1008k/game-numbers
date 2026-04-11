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
- `docs/integrations/` : 任意拡張の導入判断を整理する補助文書
- `docs/project-spec.md` : 仕様と受け入れ条件のひな形
- `docs/rules-coding.md` : 人間向けの実装判断ルール
- `docs/adr/` : 重要な設計判断を記録するテンプレート（任意）
- `AGENTS.md` : AIエージェント向けの正本となる補助文書
- `CLAUDE.md`, `GEMINI.md` : `AGENTS.md` を参照させるための互換入口
- `CONTRIBUTING.md` : 変更提案時の補助文書（任意）
- `CHANGELOG.md` : 重要な変更履歴（任意）

## AI Agent Workflow & Extensions
- AIエージェントの振る舞い、拡張運用、および技術スタックの既定案に関するルールは、すべて `AGENTS.md` を正本とします。
- `CLAUDE.md`, `GEMINI.md` などの各AI向けファイルは、`AGENTS.md` を参照する連携窓口として扱います。

## Recommended Optional Integrations
- 汎用テンプレートの段階では、実装依存の強い拡張を最初から組み込まず、必要性が高いものだけを後から有効化する。
- まず検討する候補は、`context access` を広げる拡張と、軽量なローカルメモリ拡張である。
- 推奨する任意拡張の入口は、`docs/integrations/` を参照する。
- `MCP baseline`: `filesystem`、`git`、`github` など、幅広い案件で再利用しやすい基本セット
- `GitMCP`: 外部のGitHubリポジトリやドキュメントをAIに読ませるための補助
- `OpenMemory Lite`: ローカル保存を前提にした軽量メモリ拡張
- `MemPalace` のような高機能メモリ基盤は有力な候補だが、依存、運用、成熟度の観点から既定組み込みにはしない

## Maintenance Notes
- 技術固有メモは必要になってから追加し、最初から文書を増やしすぎない
- 実装コマンドは、採用スタックが決まってから `README.md` と `AGENTS.md` に確定させる
- `ARCHITECTURE.md` は、仕様ではなく現在のコード構造を説明する文書として使う
- 重要な設計判断の理由は、必要に応じて `docs/adr/` に分離して残す

## Contributing
改善方針は [CONTRIBUTING.md](./CONTRIBUTING.md) を参照してください。
