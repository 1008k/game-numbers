# コーディングルール

共有ルールは `.shared/docs/rules-coding.md` を基本として参照します。

この文書は、`game-numbers` 固有の実装判断だけを残す入口です。優先順位と読み順は `docs/policy-index.yaml`、仕様は `docs/project-spec.md`、構造は `ARCHITECTURE.md`、実行方法は `README.md` を参照します。

## プロジェクト固有の前提
- 対象は Godot 4.x/GDScript のスマホ向け数タイルパズルです。
- 中心体験は計算ドリルではなく、限られた数タイルと記号タイルをどのゴールへ配分するかを考えるリソース管理型のパズルです。
- 主要データ構造は `docs/project-spec.md` の `StageData` と `PanelData` を正本にします。
- 想定シーン、主要スクリプト、責務分割は `ARCHITECTURE.md` を正本にします。

## Godot/GDScript 実装
- `GameManager.gd` はゲーム状態の正本を持ち、UI はその状態を表示して操作イベントを渡す役割に留めます。
- `StageGenerator.gd` はステージ生成に集中し、画面表示や広告判断を持ちません。
- `ExpressionEvaluator.gd` は `number operator number` の評価に集中し、タイル消費、スコア、画面状態を持ちません。
- `AdManager.gd`、`SaveManager.gd`、`SoundManager.gd` は外部 SDK、保存形式、音再生の詳細を閉じ込め、中心ロジックから直接ファイル操作や SDK 呼び出しを行わないようにします。

## 変更時の確認
- 仕様、受け入れ条件、データ構造に触れる変更では `docs/project-spec.md` を先に確認します。
- シーン構成、責務分割、外部連携、保存形式に触れる変更では `ARCHITECTURE.md` も更新対象に含めます。
- UI や体験の向きが変わる変更では `docs/rules-ux.md` と `DESIGN.md` を確認します。
- Godot のローカル実行方法や CLI 検証方法が変わる場合は `README.md` を更新します。

## 自動化
- Godot のエクスポート、静的検証、テスト、配布は未確定です。導入するときは、目的、対象環境、失敗時の扱いを先に文書化します。
- 繰り返し確認する手順は、保守負荷が見合う場合に `scripts/` や CI へ切り出します。
