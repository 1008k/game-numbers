# ナンバータイル

`ナンバータイル` は、数字タイルと記号タイルをゴールへ割り振り、複数の数字をぴったり成立させるスマホ向けロジックパズルです。

このリポジトリは、Godot 4.x/GDScriptで遊べる試作を育てるdocs-firstの実装リポジトリです。

## Overview
- ジャンル: 数字パズル、ロジックパズル、脳トレ、カジュアルゲーム
- 対象: iOS / Android
- エンジン: Godot 4.x
- 言語: GDScript
- 画面方向: 縦固定
- MVP: ゴール3個、有限タイル、四則演算、ミス3回、広告復活1回

## Core Idea
- ゴール数字を選ぶ。
- 数字、記号、数字の順にタイルを選んで組み合わせる。
- 正解した組み合わせで使ったタイルは消費される。
- すべてのゴールを成立させるとステージクリア。

本作の主軸は計算ドリルではなく、限られた数字リソースをどのゴールへ配分するかを考えるリソース管理型ロジックパズルです。

## Documents
- `docs/policy-index.yaml`: 参照ハブと文書優先順位
- `docs/project-spec.md`: 要件、仕様、MVP範囲、受け入れ条件の正本
- `DESIGN.md`: タイルパズル風UI、画面パターン、視覚方向
- `docs/rules-coding.md`: 実装判断とGodot/GDScript向けの最小ルール
- `docs/rules-ux.md`: UI/UX判断基準
- `docs/rules-writing.md`: 文書表記ルール
- `docs/shared-reference.md`: 共有docs/skillの同期、変更提案、リンク生成運用
- `ARCHITECTURE.md`: 想定シーン、スクリプト、責務分割
- `docs/integrations/`: 任意拡張や補助運用の判断メモ
- `docs/tracks/`: 大きめの変更の作業文脈

## Current Status
- 手作りステージを5つ遊べるGodot試作を実装中。
- 広告復活はスタブ実装。
- 広告SDK、課金、ストア公開、初期ステージ数、スコア計算は未確定。

## Run Locally
1. Godot 4.xをインストールする。
2. Godotでこのリポジトリの `project.godot` を開く。
3. メインシーン `res://scenes/Main.tscn` を実行する。

`godot` コマンド名はPATH上にありません。CLI検証では、公式配布zipを `C:\tmp\godot-cli` に展開し、`Godot_v4.6.3-stable_win64_console.exe` を使用しています。

## Prototype Flow
- ホームの `スタート` から手作りステージを開始する。
- ゴールを選び、`数字 -> 記号 -> 数字` の順でタイルを選ぶ。
- 正解したゴールはクリア済みになり、使用タイルは消費される。
- 3ゴールすべてをクリアするとクリア画面を表示し、次のステージがあれば `次へ`、最後なら `ホームへ` を表示する。
- ミスが0になるとゲームオーバー画面を表示し、1回だけ広告復活スタブを使える。

## Agent Workflow
- 最初に `docs/policy-index.yaml` を読み、参照先と優先順位を確認する。
- 仕様判断は `docs/project-spec.md` を優先する。
- UIや画面生成は `DESIGN.md` と `docs/rules-ux.md` を参照する。
- 実装構造や責務分割は `ARCHITECTURE.md` と `docs/rules-coding.md` を参照する。
- 共有skillをCodexやClaude Codeの探索先へ出す場合は `scripts/setup-agent-skill-links.ps1` を使う。
- 仕様、設計、運用に影響する大きめの変更では `docs/tracks/` に作業文脈を残す。

## Maintenance Notes
- READMEには入口情報だけを置き、仕様詳細は `docs/project-spec.md` に集約する。
- セットアップ、実行、テスト、ビルド手順は実装の進行に合わせてこのREADMEへ追記する。
- 実装構造が変わったら `ARCHITECTURE.md` を更新する。
