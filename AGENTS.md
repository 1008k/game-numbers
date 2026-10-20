# AGENTS.md

最初に `docs/policy-index.yaml` を読み、プロジェクト固有文書と読み順を解決する。共有リファレンスを共通基準とし、プロジェクト固有ルールで拡張・上書きする。

作業前に共有リファレンスの `shared-index.yaml` を確認し、作業に関係する中央文書やSkillを読む。参照には `shared-reference-router`、または `SHARED_REFERENCE_ROOT` で解決できる中央checkoutを優先する。両方利用できない場合は、認証済みrepository readerで `1008k/shared-reference@main` の `shared-index.yaml` からread-onlyで参照する。いずれも利用できなければ参照可能なプロジェクト固有ルールに従って続行し、共有基準を推測・複製しない。

共有リファレンスを参照する目的で、clone、追加credential、junction、同期処理、network integration、Hook、CI、定期実行などのプロジェクト固有機構を追加しない。

プロジェクト固有の指示とユーザーの明示指示は、中央基準より優先する。
