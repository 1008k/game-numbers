# Project Starter

このリポジトリは、実装へ進む前に仕様、設計方向、運用ルールを整理するための `docs-first` テンプレートです。

コピー後は、まず `docs/initial-brief.md` にプロジェクトの初期情報を書き、方向が固まったら `docs/project-spec.md` を正本として具体化します。

## Overview
- 用途: 新規プロジェクトの仕様整理、実装前レビュー、エージェント作業の入口
- 対象: Webアプリ、モバイルアプリ、ゲーム、CLI、ライブラリなど
- 方針: 先に目的、対象、非目的、制約、完了条件を短く整理する
- 状態: 汎用テンプレート

## Documents
- `docs/policy-index.yaml`: 参照ハブと文書優先順位
- `docs/initial-brief.md`: 仕様化前の初期メモ
- `docs/project-spec.md`: 要件、仕様、非目的、受け入れ条件の正本
- `DESIGN.md`: UIや体験を持つ案件のデザイン方向テンプレート
- `docs/rules-coding.md`: 実装判断の最小ルール
- `docs/rules-ux.md`: UI/UX判断基準
- `docs/rules-writing.md`: 文書表記ルール
- `ARCHITECTURE.md`: 実装構造、責務分割、依存関係の整理先
- `docs/integrations/`: 任意拡張や補助運用の判断メモ
- `docs/tracks/`: 大きめの変更の作業文脈

## How To Start
1. `docs/initial-brief.md` を埋める。
2. 未確定事項を分ける。
3. `docs/project-spec.md` をプロジェクトの正本として更新する。
4. 実装スタックが決まったら、必要最小限の技術固有ルールを `docs/rules-coding.md` や `ARCHITECTURE.md` に追加する。
5. UIがある場合は、`DESIGN.md` と `docs/rules-ux.md` を更新する。

## Agent Workflow
- 最初に `docs/policy-index.yaml` を読み、参照先と優先順位を確認する。
- 仕様判断は `docs/project-spec.md` を優先する。
- UIや画面生成は `DESIGN.md` と `docs/rules-ux.md` を参照する。
- 実装構造や責務分割は `ARCHITECTURE.md` と `docs/rules-coding.md` を参照する。
- 仕様、設計、運用に影響する大きめの変更では `docs/tracks/` に作業文脈を残す。

## Maintenance Notes
- READMEには入口情報だけを置き、仕様詳細は `docs/project-spec.md` に集約する。
- 実装を追加したら、セットアップ、実行、テスト、ビルド手順をこのREADMEに追記する。
- 実装構造が変わったら `ARCHITECTURE.md` を更新する。
