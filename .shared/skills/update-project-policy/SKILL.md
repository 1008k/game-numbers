---
name: update-project-policy
description: Review or update a consumer repository's AGENTS.md, routing-only docs/policy-index.yaml, and canonical project documents against the shared agent operating model. Use only when the user explicitly asks to review, adopt, or update the shared project policy.
---

<!-- managed-by: shared-reference -->
<!-- source-repo: https://github.com/1008k/shared-reference -->
<!-- source-path: .agents/skills/update-project-policy/SKILL.md -->

# Update Project Policy

共有の読み順、文書責務、作業運用を各プロジェクトへ必要なときだけ反映するskillです。通常作業では実行せず、自動の鮮度確認や同期も行いません。

## 起動条件

利用者が共有ポリシーのレビュー、導入、更新を明示的に依頼した場合だけ使います。単に実装、レビュー、文書更新を依頼された場合は起動しません。

## モード

- 最初の呼び出しは、依頼文が `更新して`、`修正して`、`適用して` を含む場合も必ずreport-onlyです。ファイルを変更せず、更新候補を提示して停止します。
- applyモードへ進めるのは、利用者が提示済みの更新候補を確認した後、後続メッセージでその内容の適用を明示した場合だけです。
- report-onlyからapplyへ移る際は、利用者が確認した対象範囲を維持し、未提示の変更を追加しません。

## ローカル文書の契約

- `AGENTS.md`: `docs/policy-index.yaml` への短い案内だけを持つ。
- `docs/policy-index.yaml`: 実在する文書のパス、役割、読み順、優先順位だけを持つ。
- canonical Markdown: プロジェクト固有の仕様、運用ルール、理由、例外を持つ。適切な既存文書がなければ `docs/project-spec.md` を使う。

policy-indexで許可する情報は次に限定します。旧schemaは移行元の分類にだけ使い、適用後の互換aliasとして残しません。

```yaml
documents: <role-to-existing-path map>
precedence: <highest-to-lowest existing paths>
read_path:
  required: <ordered existing paths>
  default: <ordered existing paths>
  situational: <task-to-existing-path map>
  avoid_up_front: <paths or directories>
```

## 確認するもの

1. `git status --short` と対象repositoryのroot。
2. `AGENTS.md`、`docs/policy-index.yaml`、`docs/project-spec.md`、`README.md`、標準文書の有無。
3. `.shared/shared-reference.lock.yaml`、`.shared/shared-index.yaml`、`.shared/docs/agent-operating-model.md` の有無。
4. 関連ファイルの未コミット変更、プロジェクト固有の仕様、より厳密な安全、監査、報告条件。
5. 共有repoの更新対象refがローカルと異なるschemaを要求する場合、vendor同期とローカル移行を同じapplyで扱う必要があること。

共有vendorが未導入なら通常更新は行わず、共有repoの `docs/install-in-project.md` にある初回導入が必要な対象として報告します。

## report-only

1. ローカル文書が担っている責務を特定する。
2. `.shared/docs/agent-operating-model.md` が存在し、policy-indexのrequired readに含まれていることを確認する。
3. required readに入口の `AGENTS.md` やpolicy-index自身が含まれていないことを確認する。
4. `AGENTS.md` にpolicy-indexへの案内以外の共有ルールまたはプロジェクト固有ルールが残っていないか確認する。
5. policy-indexを次の3種類に分類する。
   - 保持: 実在パス、文書の役割、読み順、優先順位。
   - 削除候補: 共有モデルと同等のルール本文、理由、説明、booleanの運用判断。
   - 移動候補: プロジェクト固有の仕様、例外、より厳密な条件。適切なcanonical Markdownへ移し、該当文書をpolicy-indexから辿る。
6. `docs/tracks/README.md` と `CHANGELOG.md` がなければ、最小の標準文書を作る候補に含める。
7. 追加、変更、削除の候補と、維持するプロジェクト固有記述をファイル単位で示す。候補がなければ変更不要と報告する。

report-onlyではファイル編集、共有repoのfetch、vendor同期、commit、pushを行いません。更新候補を提示したら停止し、利用者から後続の適用指示が来るまでapplyへ進みません。共有既定のためにREADMEを一律変更しません。

## apply

1. report-onlyで提示し、利用者が承認した範囲だけを対象にする。
2. 関連ファイルに安全に統合できない未コミット変更があれば停止する。無関係な変更は巻き戻さない。
3. schema移行を伴う場合は、承認された共有refへのvendor同期と次のローカル変更を同じapplyで行い、片方だけを完了状態にしない。
4. 共有相当のルールはローカル入口から削除する。プロジェクト固有のルールは削除せず、承認済みのcanonical Markdownへ移す。
5. `AGENTS.md` をpolicy-indexへの案内だけにする。
6. policy-indexを実在パス、役割、読み順、優先順位だけにする。`.shared/docs/agent-operating-model.md` をrequired readに置き、AGENTSとpolicy-index自身はrequiredに置かない。旧schemaの互換キーは残さない。
7. `docs/tracks/README.md` または `CHANGELOG.md` の作成が承認されていれば、各repositoryの実態に合う最小内容で作成し、policy-indexから必要時に辿れるようにする。
8. 標準文書以外では、存在しない文書への参照を追加しない。
9. `.shared/` を直接編集しない。共有基準を変える必要があれば正本側の変更として切り分ける。
10. 参照先の存在、repository固有の検証、`git diff --check` を確認する。
11. 同じreport-only確認を再実行し、追加の更新候補がないことを確認する。

## 報告

- report-only: 更新候補、維持・移動するローカル記述、標準文書の不足、変更不要、または初回導入が必要な状態を報告する。
- apply: 変更したローカルファイル、実施した確認、未実施の確認、残件を報告する。
- 自動同期や定期検知は提案しない。利用者が別途求めた場合だけ、既存の共有同期手順を案内する。
