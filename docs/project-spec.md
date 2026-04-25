# プロジェクト仕様書

この文書は設計方針と受け入れ条件をまとめた仕様文書です。参照先や優先順位は `docs/policy-index.yaml` を先に確認し、日々の実装判断は `docs/rules-coding.md`、セットアップと運用は `README.md` を参照してください。

## この文書の位置づけ
- この文書は「何を作るか」「どこまでを対象にするか」「何を満たせばよいか」を定義する。
- 実装ルールやコーディングスタイルは `docs/rules-coding.md` で管理する。
- 実装や文書更新の前に、完了条件と確認方法を明確にする。

## 1. プロジェクト概要
- 基本情報は `docs/project-metadata.yaml` を正本とする
- 入力ブリーフ: `docs/initial-brief.md` を起点に必要事項を具体化する
- このリポジトリ自体はアプリ実装ではなく、新規プロジェクトへコピーして使う `docs-first` テンプレートとする
- コピー後の個別プロジェクトでは、`docs/project-metadata.yaml` とこの文書を対象プロジェクトの内容に置き換える

## 2. 非目的
- 完成済みのアプリケーション、CLI、ライブラリ、インフラ構成は提供しない
- 特定の技術スタック、ホスティング先、外部サービス導入を標準として固定しない
- 個別プロジェクトの要件や非目的を、テンプレート側で推測して確定しない

## 3. 技術方針
- 想定カテゴリは `docs/project-metadata.yaml` を参照する
- 実装スタックは、要件に対して最小構成になるものを選ぶ
- 依存や基盤選定の詳細判断は `docs/rules-coding.md` に従う
- 技術スタックの既定具体例や参照順は `docs/policy-index.yaml` と `AGENTS.md` を参照する
- 既定案や慣習から外す場合は、要件との対応理由を明記する
- 採用スタックが未確定なら、先に機能要件と非機能要件を固める

## 4. 設計方針
- 変更容易性を優先し、過度に早い抽象化を避ける。
- UI、API、データモデルなどの責務境界を曖昧にしない。
- 重要な既定値、制約、対象外はこの文書に残す。

## 5. 非機能要件
- 保守しやすい構成であること
- セキュアな既定値を持つこと
- ローカル開発と CI の再現性があること
- 対象実行環境で安定動作すること

## 6. 運用拡張の検討
- 導入候補の棚卸し条件や整理観点は `docs/policy-index.yaml` の `policy.decision_defaults` と `policy.integration_catalog` を参照する
- 補足説明や判断材料は `docs/integrations/README.md` と `docs/integrations/` 配下の補助文書を参照する

## 7. 受け入れ条件
- 詳細なチェック観点は `docs/policy-index.yaml` の `policy.acceptance_checks` を参照する
- `docs/initial-brief.md` の未確定事項が整理されている
- 非目的が明文化され、実装範囲の逸脱を判断できる

## 8. リリース前チェック
- 詳細なチェック観点は `docs/policy-index.yaml` の `policy.release_checks` を参照する
- 機密情報が含まれていない
- `README.md` と `docs/rules-coding.md` と実装の整合が取れている
