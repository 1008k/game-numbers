# AGENTS.md

エージェント向けの短い入口です。最初に `docs/policy-index.yaml` を読み、参照先と優先順位を解決します。

<!-- CODEX向けの設定 https://developers.openai.com/codex/memories  -->
 [features]
memories = true

## 読み順
- `docs/policy-index.yaml`
- 以降は `policy.authority.precedence` と `policy.operating_model.default_read_path` に従う

## 要点
- このリポジトリは `docs-first` テンプレートです。
- プロジェクト種別を先に整理します。
- 可変な基本情報は `docs/project-spec.md` 冒頭の metadata に置きます。
- 実装スタック未確定なら、まず文書を整えます。
- Codexへの依頼は、可能なら `Goal / Context / Constraints / Done when` の4点を含めます。

## エージェント向け最小ルール
- 詳細は `policy.agent_minimum_rules` を参照。
- 大きい変更では探索を先に行い、結論と短い計画を先に示します。

## 完了条件と確認
- タスク完了時は、実施した確認と未実施の確認を分けて扱います。
- 変更が仕様、運用、設計判断に影響する場合は、対応する正本文書も更新対象に含めます。

## 進め方の既定
- 詳細は `policy.decision_defaults` を参照。
- 仕様化前は `docs/initial-brief.md` から始め、方向が固まったら拡張候補を棚卸しします。

## 任意の拡張運用
- 詳細は `policy.extension_policy` と `policy.integration_catalog` を参照。
- repo固有の永続設定が必要になってから `.codex/config.toml` を追加します。
- 同じ手順を繰り返すようになったら `.agents/skills/` への切り出しを検討します。

## トークン効率
- 詳細は `policy.token_efficiency` を参照。
- 品質を落とさず、正本から読み、必要な分だけ探索を広げます。
