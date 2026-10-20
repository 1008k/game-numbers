# AGENTS.md

最初に `docs/policy-index.yaml` を読み、プロジェクト固有文書と読み順を解決する。

共有リファレンスを共通基準とし、プロジェクト固有ルールで拡張・上書きする。作業前に中央の `shared-index.yaml` を確認し、作業に関係する文書やSkillを読む。参照は `shared-reference-router` を優先し、利用できない場合は `SHARED_REFERENCE_ROOT` で解決できる中央checkoutを使う。どちらも利用できない場合は、認証済みrepository readerで `1008k/shared-reference@main` の `shared-index.yaml` から作業に関係する文書やSkillをread-onlyで参照する。いずれも利用できなければ参照できるプロジェクト固有ルールに従って続行し、共有基準を推測・複製しない。

共有リファレンスを参照するためだけに、clone、追加credential、junction、同期処理、network integration、Hook、CI、定期実行などのproject固有機構を追加しない。

ユーザーの明示指示とプロジェクト固有のルールは、共有ルールより優先する。
