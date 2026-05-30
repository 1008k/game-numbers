# Architecture Overview

この文書は、`計算パネルパズル` の実装構造を素早く把握する補助文書です。仕様の正本は `docs/project-spec.md`、実装判断は `docs/rules-coding.md` を参照します。

現時点ではアプリ実装は未作成のため、ここでは予定するGodotシーン、スクリプト、責務分割を記載します。実装が進んだら実態に合わせて更新します。

## 1. 位置づけ
- 対象: Godot 4.x/GDScriptで実装予定のスマホ向けパズルゲーム
- 目的: UI、ゲーム進行、ステージ生成、式評価、広告、保存の責務を分けて把握する
- 更新タイミング: シーン構成、主要スクリプト、外部連携、保存形式、ビルド手順が変わったとき

## 2. 予定シーン
```text
Main.tscn
HomeScreen.tscn
GameScreen.tscn
PanelButton.tscn
TargetItem.tscn
ClearDialog.tscn
```

- `Main.tscn`: アプリ起動点と画面遷移の親。
- `HomeScreen.tscn`: スタート、設定、MVP後の追加導線の入口。
- `GameScreen.tscn`: ステージ情報、ターゲット、現在の式、パネル、補助操作を表示する中心画面。
- `PanelButton.tscn`: 数字パネルと演算子パネルの共通表示部品。
- `TargetItem.tscn`: ターゲット数字の表示、選択中、クリア済み状態。
- `ClearDialog.tscn`: クリア演出、スコア、次へ、リワード導線。

## 3. 予定スクリプト
```text
GameManager.gd
StageGenerator.gd
ExpressionEvaluator.gd
AdManager.gd
SaveManager.gd
SoundManager.gd
```

- `GameManager.gd`: ステージ進行、ターゲット選択、式入力状態、ミス、クリア、ゲームオーバーを管理する。
- `StageGenerator.gd`: 先に解答を作り、ターゲットとパネルを生成する。
- `ExpressionEvaluator.gd`: `number operator number` の式評価、0除算、不成立判定を扱う。
- `AdManager.gd`: リワード広告復活など広告SDK境界を扱う。
- `SaveManager.gd`: 進捗、設定、MVP後に追加する購入状態などのローカル保存を扱う。
- `SoundManager.gd`: 電卓SE、正解、ミス、クリアなどの音を扱う。

## 4. 責務分割
- 中心ロジックはUI、広告SDK、保存形式に依存させない。
- `StageGenerator.gd` はステージ生成だけを担い、画面表示や広告判断を持たない。
- `ExpressionEvaluator.gd` は式評価だけを担い、パネル消費やスコア計算を持たない。
- `GameManager.gd` はゲーム状態の正本を持ち、UIはその状態を表示して操作イベントを渡す。
- `AdManager.gd` は外部SDKの詳細を閉じ込め、復活可否などの結果だけをゲーム側へ返す。
- `SaveManager.gd` は保存先の詳細を閉じ込め、ゲームロジックから直接ファイル操作させない。

## 5. データ構造
主要データ構造は `docs/project-spec.md` の `StageData` と `PanelData` を正とします。

- `StageData`: targets、panels、solutions、difficulty、max_mistakes
- `PanelData`: display_text、value、type、used

## 6. 外部連携
- MVPで扱う外部連携はリワード広告のみ。
- 広告SDK、課金、分析基盤、ランキング、デイリー配信はMVP後に具体化する。
- 外部連携を追加する場合は、目的、影響範囲、必要権限、失敗時の扱いを仕様またはtrackに残す。

## 7. ビルド / テスト / デプロイ
- ビルド方法: 未定義。Godotプロジェクト作成後にREADMEへ追記する。
- テスト方法: 未定義。式評価とステージ生成は自動テスト対象にする。
- 配布方法: iOS/Androidのストア公開を想定するが、MVP仕様整理時点では対象外。
- CI: 未定義。実装開始後にエクスポート、静的検査、テストの自動化を検討する。

## 8. 今後の見直し候補
- 正式タイトル。
- 初期ステージ数と難易度カーブ。
- スコア計算。
- 広告SDKと課金方式。
- セーブデータ形式。
- Godotプロジェクトの実ディレクトリ構成。
