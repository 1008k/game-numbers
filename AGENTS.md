# AGENTS.md

最初に `docs/policy-index.yaml` を読み、プロジェクト固有文書と読み順を解決します。

共有ルールや共有Skillが必要な場合は、利用可能なら `shared-reference-router` を使います。routerを利用できなくても `SHARED_REFERENCE_ROOT` で中央checkoutを解決できる場合は、そこから必要な中央文書やSkillだけを参照します。どちらも利用できず、認証済みrepository readerで `1008k/shared-reference` を読める場合は、`main` の `shared-index.yaml` から必要な中央文書やSkillだけをread-onlyで参照します。いずれも利用できない場合はプロジェクト固有ルールだけで続行し、共有基準を推測・複製しません。

共有リファレンスを参照するためだけに、clone、追加credential、junction、同期処理、network integration、Hook、CI、定期実行などのproject固有機構を追加しません。

ユーザーの明示指示とプロジェクト固有のルールは、共有ルールより優先します。
