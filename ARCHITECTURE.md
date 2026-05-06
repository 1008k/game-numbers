# Architecture Overview

この文書は、実装が進んだ後のコードベース構造を素早く把握する補助文書です。
このリポジトリ自体はアプリ実装を含まない `docs-first` テンプレートなので、ここではテンプレートとしての現在構成を記載します。
コピー後の個別プロジェクトで実装を始めたら、この文書を実装済みの構造、責務分割、依存関係に合わせて更新します。

## 1. 位置づけ
- 対象: Project Starter Template 自体の文書構成
- 目的: 人とAIエージェントが、テンプレートの正本、補助文書、任意拡張の位置づけを短時間で把握する
- 更新タイミング: コア文書、参照優先順位、リポジトリ固有ワークフロー、任意拡張の構成が変わったとき

## 2. プロジェクト構造
- 主要ディレクトリ:
  ```text
  .
  ├── .agents/skills/              # リポジトリ固有の再利用ワークフロー
  ├── docs/
  │   ├── adr/                     # 設計判断記録のテンプレート
  │   ├── integrations/            # 任意拡張の判断材料
  │   ├── initial-brief.md         # 初回要件整理の簡易ブリーフ
  │   ├── policy-index.yaml        # 参照ハブと静的項目（正本）
  │   ├── project-metadata.yaml    # 可変な基本情報
  │   ├── project-spec.md          # 要件定義と仕様の正本
  │   ├── rules-coding.md          # 実装判断の説明
  │   ├── rules-ux.md              # UI/UX判断基準
  │   └── rules-writing.md         # 文書表記ルール
  ├── AGENTS.md                    # AIエージェント向け入口
  ├── DESIGN.md                    # 持ち運び可能なデザイン方向
  ├── CLAUDE.md                    # AGENTS.md互換入口（Claude向け）
  ├── GEMINI.md                    # AGENTS.md互換入口（Gemini向け）
  ├── .cursorrules                 # AGENTS.md互換入口（Cursor向け）
  ├── .windsurfrules               # AGENTS.md互換入口（Windsurf向け）
  ├── ARCHITECTURE.md              # この構造説明
  ├── CONTRIBUTING.md              # 変更提案の補助文書
  ├── CHANGELOG.md                 # 重要な変更履歴
  └── README.md                    # 人とエージェント向け概要
  ```
- 主要ファイル: `docs/policy-index.yaml` が参照ハブ、`docs/project-metadata.yaml` がテンプレート基本情報、`docs/project-spec.md` が要件定義と仕様の雛形を扱う。
- 補助ルール: `docs/rules-coding.md` が実装判断、`docs/rules-ux.md` がユーザー向けUI判断、`docs/rules-writing.md` が文書表記を扱う。
- デザイン方向: `DESIGN.md` がユーザー向けUIを持つプロジェクトで、AIデザインツールやコーディングエージェント間に持ち運ぶ視覚方向、コンポーネント規則、画面パターンを扱う。
- レイヤーやモジュールの分け方: 実装レイヤーはまだ持たず、文書の正本、説明文書、任意テンプレート、補助ワークフローを分ける。

## 3. 中心となる責務
- `docs/policy-index.yaml`:
  - 役割: 参照先、優先順位、状態、静的チェック、既定判断を集約する
  - 主な依存先: なし
  - 変更時の注意: Markdown文書に置くべき理由説明や例示を増やしすぎない
- `docs/project-metadata.yaml`:
  - 役割: テンプレート自身またはコピー後プロジェクトの短い基本情報を保持する
  - 主な依存先: `docs/project-spec.md`
  - 変更時の注意: 長い理由や制約は仕様文書へ寄せる
- `docs/project-spec.md`:
  - 役割: なぜ作るか、何を作るか、対象範囲、振る舞い、データ構造、非目的、受け入れ条件を具体化
  - 主な依存先: `docs/project-metadata.yaml`, `docs/initial-brief.md`
  - 変更時の注意: 実装ルールやセットアップ手順を重複させない
- `docs/rules-ux.md`:
  - 役割: ユーザー向けUIの設計、実装、レビュー時の判断基準を保持
  - 主な依存先: `docs/policy-index.yaml`, `docs/project-spec.md`, `DESIGN.md`
  - 変更時の注意: 画面ごとの具体仕様は `docs/project-spec.md`、プロジェクト固有の視覚方向は `DESIGN.md` に置き、この文書には共通判断だけを残す
- `DESIGN.md`:
  - 役割: プロジェクト固有のデザイン方向、コンポーネント規則、画面パターンを保持
  - 主な依存先: `docs/rules-ux.md`, `docs/project-spec.md`
  - 変更時の注意: UX一般原則や機能要件を重複させず、Stitchなど外部デザインツールに戻しやすい短いルールとして保つ
- `.agents/skills/`:
  - 役割: 繰り返し使うリポジトリ固有ワークフローを保持
  - 主な依存先: `docs/policy-index.yaml`, `docs/project-spec.md`, `README.md`
  - 変更時の注意: 常時効かせたい短いルールは `AGENTS.md` へ戻す

## 4. データや処理の流れ
- 主な入力: `docs/initial-brief.md` に書かれた初期要件
- 中心ロジック: `docs/policy-index.yaml` の参照優先順位に従い、metadata、仕様、ルール文書を具体化する
- 外部出力: コピー後プロジェクトのREADME、仕様、実装雛形、必要に応じたADR
- 境界がある箇所: 外部連携、認証、常駐処理、監査やセキュリティに関わる拡張の導入判断

## 5. 外部連携
- 標準状態:
  - 用途: 外部サービス連携はテンプレートに含めない
  - 接続方法: 必要になった段階で `docs/integrations/` を参照して個別採用する
  - 失敗時の扱い: 連携なしで文書具体化を継続できる状態を保つ

## 6. ビルド / テスト / デプロイ
- ビルド方法: アプリ実装がないため未定義
- テスト方法: 採用スタック決定後に `README.md` と `docs/rules-coding.md` へ追記する
- 配布またはデプロイ方法: テンプレートとしてコピーして使う
- CIで担保していること: 現時点では未定義

## 7. 制約と今後の見直し候補
- 現在の制約: 実装スタックや実行コマンドはコピー後プロジェクトで確定する
- 技術的負債: 文書テンプレートの品質確認は手動レビューに依存している
- 今後見直す可能性が高い箇所: 文書整合チェック、プレースホルダー検出、Markdown/YAMLの静的検査
