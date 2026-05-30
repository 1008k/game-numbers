# 計算パネルパズル

`計算パネルパズル` は、数字パネルと演算子パネルを消費しながら複数のターゲット数字を成立させる、スマホ向けの計算ロジックパズル企画です。

このリポジトリは、Godot 4.x/GDScriptで実装へ進む前の仕様、デザイン方向、実装ルールを整理するdocs-firstの企画リポジトリです。現時点ではアプリ実装は含みません。

## Overview
- ジャンル: 数字パズル、ロジックパズル、脳トレ、カジュアルゲーム
- 対象: iOS / Android
- エンジン: Godot 4.x
- 言語: GDScript
- 画面方向: 縦固定
- MVP: ターゲット3個、有限パネル、四則演算、ミス3回、広告復活1回

## Core Idea
- ターゲット数字を選ぶ。
- 数字、演算子、数字の順にパネルを選んで式を作る。
- 正解した式で使ったパネルは消費される。
- すべてのターゲットを成立させるとステージクリア。

本作の主軸は計算ドリルではなく、限られた数字リソースをどのターゲットへ配分するかを考えるリソース管理型ロジックパズルです。

## Documents
- `docs/policy-index.yaml`: 参照ハブと文書優先順位
- `docs/project-spec.md`: 要件、仕様、MVP範囲、受け入れ条件の正本
- `DESIGN.md`: 電卓風UI、画面パターン、視覚方向
- `docs/rules-coding.md`: 実装判断とGodot/GDScript向けの最小ルール
- `docs/rules-ux.md`: UI/UX判断基準
- `ARCHITECTURE.md`: 想定シーン、スクリプト、責務分割
- `docs/tracks/`: 大きめの変更の作業文脈

## Current Status
- 仕様整理中。
- 実装スタックはGodot 4.x/GDScriptを前提にする。
- 広告SDK、課金、ストア公開、初期ステージ数、スコア計算は未確定。

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
