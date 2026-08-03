<!-- managed-by: shared-reference -->
<!-- source-repo: https://github.com/1008k/shared-reference -->
<!-- source-path: docs/install-in-project.md -->
# Install Or Update Shared Reference In A Project

Use these prompts with a coding agent when installing `shared-reference` into an existing project or updating an already adopted project.

Policy freshness is not checked during ordinary project work. Use the opt-in `update-project-policy` skill only when a policy review or update is explicitly requested. Every invocation first reports proposed changes and stops; a later user message must approve that presented scope before files are changed.

## Install Prompt

Use this when the project does not have `.shared/shared-reference.lock.yaml` yet.

### Full Prompt

````md
# shared-reference をこのプロジェクトに導入してください

このプロジェクトに、共有参照 repo `https://github.com/1008k/shared-reference.git` の vendor 同期運用を導入してください。

## Goal

- `shared-reference` の共有 docs / skills を、このプロジェクトの `.shared/` 配下に vendor コピーとして取り込む。
- プロジェクト固有の docs / rules / skills は残し、共有版で代替できる古い重複ルールや skill は整理する。
- 共有管理ファイルは直接編集せず、正本編集フローを使える状態にする。

## First

1. `git status --short --branch` と `git remote -v` を確認する。
2. `docs/policy-index.yaml` があれば読み、文書の正本と読み順を確認する。
3. `AGENTS.md`, `docs/rules-*.md`, `.agents/skills/`, `.shared/` の既存状態を確認する。
4. 既存の未コミット変更がある場合は巻き戻さず、今回の変更と混ぜてよいか慎重に判断する。

## Install

- `shared-reference` repo が隣接ディレクトリにあればそれを使う。
- なければ `https://github.com/1008k/shared-reference.git` を適切な場所に clone する。
- `shared-reference/scripts/adopt-shared-reference.ps1` を使って導入する。
- 導入後、以下が存在することを確認する。

```txt
.shared/shared-reference.lock.yaml
.shared/shared-index.yaml
.shared/docs/agent-operating-model.md
.shared/docs/rules-coding.md
.shared/docs/rules-ux.md
.shared/docs/rules-writing.md
.shared/skills/skills-index.md
.shared/skills/update-project-policy/SKILL.md
scripts/sync-shared-reference.ps1
scripts/propose-shared-reference-change.ps1
```

## Cleanup

- 旧 `agent-rules` / `.agents/shared-rules/` / `.shared/docs/shared-rules/` / `.shared/docs/integrations/` が残っていれば、共有管理ファイルかどうかを確認して整理する。
- 共有版で代替できる一般論、古い運用メモ、重複 skill は削除または短縮する。
- プロジェクト固有の仕様、互換性、ドメイン知識、公開仕様、既存UI/保存形式に関わるルールは残す。
- 判断に迷うものは削除せず、最終報告で「要確認」として挙げる。

## Project Docs

- 既存の `AGENTS.md` と `docs/policy-index.yaml` があれば、プロジェクト固有の記述を適切な正本文書へ保持したまま共有ポリシーへの入口を最小限追加・調整する。存在しない場合だけ新規作成する。
- `docs/policy-index.yaml` のrequired readに `.shared/docs/agent-operating-model.md` を追加する。`AGENTS.md` はpolicy-indexへの案内だけにし、共有ルールやプロジェクト固有ルールを置かない。
- policy-indexは実在文書のパス、役割、読み順、優先順位だけにする。共有相当のルールは削除し、より厳密な安全、監査、報告条件などの固有ルールは適切な正本文書、なければ `docs/project-spec.md` へ移す。このために `README.md` を一律変更しない。
- `docs/tracks/README.md` または `CHANGELOG.md` がなければ、最小の標準文書として作成する。
- `docs/rules-coding.md`, `docs/rules-ux.md`, `docs/rules-writing.md` はプロジェクト固有の入口として残す。
- 各ファイルから共有ルールを参照する。

```md
共有ルールは `.shared/docs/rules-coding.md` を基本として参照します。
```

- `docs/policy-index.yaml` から `.shared/shared-index.yaml`、`.shared/shared-reference.lock.yaml`、`.shared/skills/update-project-policy/SKILL.md` を必要時に辿り、`.shared/docs/agent-operating-model.md` はrequired readに置く。優先順位はプロジェクト固有docsが共有版を上書きする形にする。
- 通常作業ではポリシーの鮮度確認や更新を行わない。必要なときだけ `update-project-policy` skillを明示的に呼び出す。最初の依頼が更新指示でも必ずreport-onlyで停止するため、結果を確認した後の別メッセージで提示範囲の適用を依頼する。
- この運用のために自動同期、CIやhooksによる鮮度確認、定期実行、バックグラウンド処理を追加しない。

## Verify

- `scripts/sync-shared-reference.ps1 -DryRun`
- `scripts/propose-shared-reference-change.ps1 -VendorPath .shared/shared-index.yaml`
- 可能なら `shared-reference/scripts/validate-shared-reference.ps1`
- `git diff --check`

## Done When

- `.shared/` に共有 docs / skills が同期されている。
- `.shared/docs/agent-operating-model.md` と `.shared/skills/update-project-policy/SKILL.md` が同期されている。
- `AGENTS.md` から `docs/policy-index.yaml` へ進み、そこから共有ポリシーと更新skillを必要時に辿れる。
- `docs/policy-index.yaml` のrequired readに `.shared/docs/agent-operating-model.md` があり、AGENTSはpolicy-indexへの案内だけ、policy-indexは文書地図だけを持つ。
- `docs/tracks/README.md` と `CHANGELOG.md` が存在する。
- lock file が `https://github.com/1008k/shared-reference.git` と commit SHA を記録している。
- プロジェクト固有ルールが失われていない。
- 共有版で代替できる古い重複ルールや skill が整理されている。
- `policy-index.yaml` / `AGENTS.md` / `docs/rules-*.md` の参照が矛盾していない。
- 検証結果、削除/短縮した項目、残した項目、未実施確認が報告されている。
- 問題なければコミットし、push 可能なら push する。
````

### Short Prompt

```md
このプロジェクトに `https://github.com/1008k/shared-reference.git` を導入してください。

まず git 状態、remote、`docs/policy-index.yaml`、`AGENTS.md`、`docs/rules-*.md`、既存 `.agents/skills/` と `.shared/` を確認してください。

`shared-reference/scripts/adopt-shared-reference.ps1` を使って `.shared/` へ vendor 同期し、`.shared/shared-reference.lock.yaml`、`.shared/shared-index.yaml`、`.shared/docs/rules-*.md`、`.shared/skills/skills-index.md`、`scripts/sync-shared-reference.ps1`、`scripts/propose-shared-reference-change.ps1` を導入してください。

`.shared/docs/agent-operating-model.md` と `.shared/skills/update-project-policy/SKILL.md` も同期対象です。`AGENTS.md` は `docs/policy-index.yaml` への案内だけ、policy-indexは実在文書のパス、役割、読み順、優先順位だけにしてください。共有vendor pathはpolicy-indexから必要時に辿ります。通常作業ではポリシー更新を確認せず、自動同期、CI、hooks、定期処理、バックグラウンド処理を追加しません。skillは最初の依頼が更新指示でも必ずreport-onlyで停止し、提示内容を確認した後の別メッセージで適用を依頼します。

既存のプロジェクト固有ルールや skill は無条件に消さず、共有版で代替できる一般論・古い運用メモ・重複 skill だけ削除または短縮してください。プロジェクト固有の仕様、互換性、ドメイン知識、公開仕様は残してください。

既存の `AGENTS.md` と `docs/policy-index.yaml` は、プロジェクト固有の記述を適切な正本文書へ保持したまま共有ポリシーへの入口だけを最小限追加・調整し、存在しない場合だけ新規作成してください。`docs/rules-*.md` も保持し、プロジェクト固有docsが共有版を上書きする構造にしてください。

policy-indexのrequired readに `.shared/docs/agent-operating-model.md` を追加してください。`AGENTS.md` はpolicy-indexへの案内だけ、policy-indexは実在文書のパス、役割、読み順、優先順位だけにしてください。共有相当のルールはローカル入口から削除し、プロジェクト固有のルールは適切な正本文書、なければ `docs/project-spec.md` へ移してください。`docs/tracks/README.md` と `CHANGELOG.md` がなければ最小ファイルを作成し、このために `README.md` を一律変更しないでください。

最後に `scripts/sync-shared-reference.ps1 -DryRun`、`scripts/propose-shared-reference-change.ps1 -VendorPath .shared/shared-index.yaml`、`git diff --check` を確認し、問題なければコミット・push してください。
```

## Update Prompt

Use this when the project already has `.shared/shared-reference.lock.yaml`.

### Full Prompt

````md
# shared-reference を最新化してください

このプロジェクトに導入済みの `shared-reference` vendor コピーを、共有 repo の最新 commit に同期してください。

## Goal

- `https://github.com/1008k/shared-reference.git` の最新 `main` を取り込む。
- `.shared/` 配下の managed docs / skills と `.shared/shared-reference.lock.yaml` を更新する。
- プロジェクト固有の docs / rules / skills は保持し、共有版の更新で不要になった重複だけ整理する。
- managed file にローカル変更がある場合は直接上書きせず、正本編集フローへ切り分ける。

## First

1. `git status --short --branch` と `git remote -v` を確認する。
2. `.shared/shared-reference.lock.yaml` を読み、source repo、local path、現在の ref、disabled entries を確認する。
3. `docs/policy-index.yaml` があれば読み、`.shared/shared-index.yaml` の参照と優先順位を確認する。
4. 既存の未コミット変更がある場合は巻き戻さず、今回の同期差分と混ぜてよいか慎重に判断する。
5. 更新対象refの共有モデルが現在のローカルpolicy-indexと異なるschemaを要求するか確認する。

## Update

- `shared-reference` repo が lock file の `source.local_path` または隣接ディレクトリにあればそれを使う。
- なければ `https://github.com/1008k/shared-reference.git` を適切な場所に clone する。
- 共有 repo を最新化する。

```powershell
git -C ..\shared-reference fetch origin
git -C ..\shared-reference switch main
git -C ..\shared-reference pull --ff-only
$ref = git -C ..\shared-reference rev-parse HEAD
```

- schema変更がなければ、導入先プロジェクトでdry-runしてから同期する。

```powershell
scripts\sync-shared-reference.ps1 -Ref $ref -DryRun
scripts\sync-shared-reference.ps1 -Ref $ref
```

schema変更がある場合はvendor同期を実行せず、共有repo側の `update-project-policy` skillを使って、共有ref、`AGENTS.md`、policy-index、canonical Markdownを同じ変更単位で移行するreport-only候補を提示して停止する。後続メッセージで承認されたapplyの中でのみ、dry-run、vendor同期、ローカル移行をまとめて行う。旧schemaの互換キーは追加しない。

schema変更がなく、ローカル文書も共有基準と照合したい場合だけ、同期後に `update-project-policy` skillを明示的に呼び出す。最初の依頼が更新指示でもreport-onlyの結果を提示して停止するため、その内容を確認し、変更が必要なら後続メッセージで提示範囲の適用を依頼する。

この運用のために自動同期、CIやhooksによる鮮度確認、定期実行、バックグラウンド処理を追加しない。

## Cleanup

- 承認済みのpolicy applyに含まれる場合だけ、共有版で代替できる一般論、古い運用メモ、重複skillをプロジェクト固有docs / `.agents/skills/` から削除または短縮する。vendor同期だけの依頼では候補の報告に留める。
- プロジェクト固有の仕様、互換性、ドメイン知識、公開仕様、既存UI/保存形式に関わるルールは残す。
- `disabled` entries がある場合は、今回の更新後も除外理由が妥当か確認する。
- managed file を変更したくなった場合は、`.shared/` を直接編集せず `scripts/propose-shared-reference-change.ps1 -VendorPath <path>` で共有 repo 側へ変更を作る。

## Verify

- `scripts/sync-shared-reference.ps1 -DryRun`
- `scripts/propose-shared-reference-change.ps1 -VendorPath .shared/shared-index.yaml`
- `git diff --check`
- 必要なら、共有 repo 側で `scripts/validate-shared-reference.ps1`

## Done When

- `.shared/shared-reference.lock.yaml` の ref が取り込んだ commit SHA に更新されている。
- `.shared/` の managed docs / skills が同期されている。
- ローカルの `AGENTS.md` から `docs/policy-index.yaml` へ進み、そこから共有ポリシーと更新skillを必要時に辿れる。
- ポリシー更新を依頼した場合は、report-onlyの候補を確認してからローカル入口へ適用されている。
- ポリシー更新を依頼した場合は、共有モデルがrequired readにあり、AGENTSはpolicy-indexへの案内だけ、policy-indexは文書地図だけを持つ。
- ポリシー更新を依頼した場合は、`docs/tracks/README.md` と `CHANGELOG.md` が存在する。
- プロジェクト固有ルールが失われていない。
- 共有版で代替できる古い重複ルールや skill が整理されている。
- `policy-index.yaml` / `AGENTS.md` / `docs/rules-*.md` の参照が矛盾していない。
- 検証結果、削除/短縮した項目、残した項目、未実施確認が報告されている。
- 問題なければコミットし、push 可能なら push する。
````

### Short Prompt

```md
このプロジェクトに導入済みの `https://github.com/1008k/shared-reference.git` を最新化してください。

まず git 状態、remote、`.shared/shared-reference.lock.yaml`、`docs/policy-index.yaml`、`AGENTS.md`、`docs/rules-*.md`、既存 `.agents/skills/` を確認してください。

`shared-reference` repoを最新の `main` に更新し、更新対象refの共有モデルが現在のローカルpolicy-indexと異なるschemaを要求するか確認してください。schema変更がなければ、そのcommit SHAを使って `scripts/sync-shared-reference.ps1 -Ref <commit> -DryRun`、問題なければ `scripts/sync-shared-reference.ps1 -Ref <commit>` を実行してください。

schema変更がある場合はvendor同期を行わず、共有repo側の `.agents/skills/update-project-policy/SKILL.md` を使い、共有refとローカル入口を同じ変更単位で移行するreport-only候補を提示して停止してください。後続メッセージで承認されたapplyの中でだけdry-run、vendor同期、ローカル移行を行い、旧schemaの互換キーは追加しないでください。

schema変更がなく、ローカルの `AGENTS.md` と `docs/policy-index.yaml` も共有基準へ更新する依頼の場合だけ、同期後に `.shared/skills/update-project-policy/SKILL.md` を使ってreport-onlyの候補を提示してください。共有モデルをrequired readに置き、AGENTSはpolicy-indexへの案内だけ、policy-indexは実在文書のパス、役割、読み順、優先順位だけにしてください。共有相当のルールは削除候補、プロジェクト固有の条件はcanonical Markdownへの移動候補として示し、標準のtrack・CHANGELOGがなければ作成候補に含めてください。提示内容を確認した後の別メッセージで承認されるまで適用せず、自動同期、CI、hooks、定期処理、バックグラウンド処理を追加しないでください。

承認済みのpolicy applyに含まれる場合だけ、共有版で代替できる一般論・古い運用メモ・重複skillを削除または短縮してください。vendor同期だけの依頼では変更せず候補を報告し、プロジェクト固有の仕様、互換性、ドメイン知識、公開仕様は残してください。

managed file を変更したくなった場合は `.shared/` を直接編集せず、`scripts/propose-shared-reference-change.ps1 -VendorPath <path>` で共有 repo 側へ変更してください。

最後に `scripts/sync-shared-reference.ps1 -DryRun`、`scripts/propose-shared-reference-change.ps1 -VendorPath .shared/shared-index.yaml`、`git diff --check` を確認し、問題なければコミット・push してください。
```
