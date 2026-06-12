---
version: 1

project:
  name: "Project Starter"
  summary: "新規プロジェクトの仕様、設計、運用ルールを整えるdocs-firstテンプレート"
  goal: "実装前に目的、対象、非目的、制約、完了条件を整理し、エージェントと人が同じ正本を参照できる状態を作る"
  target_users_and_scope: "新規プロジェクトを始める開発者、企画者、AIエージェント"
  category: "project template"

template:
  is_template: true
  intended_use: docs-first-project-starter
  replace_project_fields_after_copy: true

status:
  brief_source: docs/initial-brief.md
  metadata_state: template

conventions:
  language_for_keys: english
  keep_values_short: true
  rationale_belongs_in: docs/project-spec.md
---

# プロジェクト仕様書

この文書は、コピー後プロジェクトの要件定義と仕様の正本です。テンプレートのまま使う場合は、下の各節を具体プロジェクトに合わせて更新します。参照先や優先順位は `docs/policy-index.yaml` を先に確認します。

## 1. 目的
- このリポジトリは、実装前にプロジェクトの方向を整理するためのdocs-firstテンプレートです。
- 目的、対象ユーザー、非目的、制約、受け入れ条件を先に明確にし、実装時の判断ぶれを減らします。
- 実装スタックが未確定な段階では、技術固有の設定やコードを増やしすぎないことを優先します。

## 2. 対象
- 新規プロジェクトの初期設計。
- AIエージェントと人間が同じ文書を参照して作業するプロジェクト。
- Web、モバイル、ゲーム、CLI、ライブラリ、ドキュメントプロジェクトなど、特定スタックに固定しない案件。

## 3. 使い方
- `docs/initial-brief.md` に初期情報を書く。
- 本文書の metadata と各節を、具体プロジェクトの正本として更新する。
- 仕様、設計、運用に影響する大きめの変更では `docs/tracks/` に作業文脈を残す。
- 実装を追加したら、README、ARCHITECTURE、ルール文書の責務に沿って必要な情報だけを追記する。

## 4. 決めること
- プロジェクト名。
- プロジェクト種別。
- 何を作るか。
- 誰のために作るか。
- 今回やること。
- 今回やらないこと。
- 採用スタック。
- 外部連携、権限、データ保存の有無。
- 完了条件と確認方法。

## 5. 非目的
- このテンプレート自体では、特定のアプリ、ゲーム、サービス仕様を固定しない。
- 実装スタックを先回りして固定しない。
- 外部サービス、MCP、hooks、automation、memoryなどの拡張を標準必須にしない。
- コピー後プロジェクトの詳細仕様を、テンプレートに残し続けない。

## 6. 文書の役割
- `docs/project-spec.md`: 何を作るか、何を対象外にするか、受け入れ条件の正本。
- `README.md`: 人とエージェントの入口、セットアップ、参照導線。
- `ARCHITECTURE.md`: 実装構造、責務分割、依存関係。
- `DESIGN.md`: UIや体験を持つ案件のデザイン方向。
- `docs/rules-coding.md`: 実装判断の共通ルール。
- `docs/rules-ux.md`: UI/UX判断の共通ルール。
- `docs/rules-writing.md`: 文書表記ルール。

## 7. 受け入れ条件
- コピー後プロジェクトで、目的、対象、非目的、制約、完了条件が読み取れる。
- READMEが入口情報に留まり、仕様詳細が `docs/project-spec.md` に集約されている。
- 実装構造がある場合は `ARCHITECTURE.md` から把握できる。
- UIがある場合は `DESIGN.md` と `docs/rules-ux.md` から体験方針が読み取れる。
- 不要なテンプレート文言や別プロジェクト固有の記述が残っていない。
