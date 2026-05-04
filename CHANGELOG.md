# Changelog

## [Unreleased]
- Stitchなどへ持ち運べるデザイン方向テンプレートとして `DESIGN.md` を追加
- UI/UXルールと `DESIGN.md` の責務分担を整理
- テンプレート利用時に仕様文書の整合確認と初期具体化を進めやすくする補助workflowを追加
- repo固有skillを追加すべき場面を判断できるガイドを追加

## [1.0.0] - 2026-04

### Added
- `docs/initial-brief.md` を追加
- `.gitignore` を追加
- `CONTRIBUTING.md` を追加
- `ARCHITECTURE.md` を追加し、仕様とコード構造の役割を分ける方針を明記
- ADR テンプレートを追加し、設計判断の理由を残す導線を追加

### Changed
- テンプレートの位置づけを docs-first な開発プロジェクト向けに整理
- `README.template.md` と `SETUP_PROMPT.md` を削除し、導線を `README.md` と `docs/initial-brief.md` に集約
- `Web` 固定の説明を外し、複数のプロジェクト種別に対応できる文面へ調整
- 公開成果物は CI で作成し、ローカルのビルド成果物を Git 管理しない方針を追記
- `docs/rules-coding.md` の設計原則を整理し、重複するルールを統合
- Git 管理対象の考え方を、ローカル専用物全般を含む包括的な表現に整理
- 生成物の扱いに関する責務を `README.md` から外し、ルール文書と `CONTRIBUTING.md` に寄せる
