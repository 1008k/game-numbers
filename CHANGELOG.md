# Changelog

このリポジトリの重要な変更を記録します。
形式は Keep a Changelog、バージョニングは Semantic Versioning を前提にします。

## [Unreleased]
### Changed
- テンプレートの位置づけを docs-first な開発プロジェクト向けに整理
- `README.template.md` と `SETUP_PROMPT.md` を削除し、導線を `README.md` と `docs/initial-brief.md` に集約
- `Web` 固定の説明を外し、複数のプロジェクト種別に対応できる文面へ調整
- 公開成果物は CI で作成し、ローカルのビルド成果物を Git 管理しない方針を追記
- `docs/coding-rules.md` の設計原則を整理し、重複するルールを統合
- Git 管理対象の考え方を、ローカル専用物全般を含む包括的な表現に整理
- 生成物の扱いに関する責務を `README.md` から外し、ルール文書と `CONTRIBUTING.md` に寄せる

### Added
- `docs/initial-brief.md` を追加
- `.gitignore` を追加
- `CONTRIBUTING.md` を追加
