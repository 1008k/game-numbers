# Track Spec: Modern Web Guidance integration

## Background
- 背景: ブラウザ向け案件で最新のWeb実践を取り込みやすくしたい
- 問題: テンプレートには現代的なWeb Platform活用や、アクセシビリティ、性能、セキュリティをまとめて参照する入口がまだない
- きっかけ: Chrome for Developers の Modern Web Guidance をプロジェクトへなるべく組み込みたいという会話

## Scope
- 対象: `docs/rules-coding.md`、`docs/rules-ux.md`、`docs/project-spec.md`、`README.md`、`docs/integrations/`
- 対象外: 実装スタックの固定、外部ツールの強制導入、repo固有skillの新設

## Decisions
- 判断1: Web UI 案件でだけ効く最小ルールを正本文書へ追加する
- 判断2: 詳細な導入判断と参照先は `docs/integrations/modern-web-guidance.md` に分離する

## Constraints
- 制約: docs-first の責務分担を崩さないこと
- 制約: 外部ガイダンスは観測として扱い、仕様や制約より優先しないこと

## Done When
- Web UI 案件で Modern Web Guidance を検討する入口が追加されている
- 仕様、実装、UX の正本文書に最小限の判断基準が反映されている

## Follow-up
- 実案件で繰り返し使う観点が固まったら、repo固有skillやチェックリスト化を検討する
