# Shared Reference

このプロジェクトは、共有repo `shared-reference` から一部の文書とskillをvendorコピーとして取り込みます。

## 共有管理対象

- `.shared/docs/`
- `.shared/skills/`

共有管理ファイルは直接編集せず、正本である `shared-reference` 側を更新してから同期します。プロジェクト固有の事情は、共有ファイルを書き換えずに、このプロジェクト内の追加文書や独自skillとして置きます。

共有skillと補助運用の導入判断は `.shared/skills/skills-index.md` に同期されます。プロジェクト固有の補足が増えた場合だけ、必要に応じて `docs/` 配下に置き場を追加します。

`docs/rules-coding.md`、`docs/rules-ux.md`、`docs/rules-writing.md` は共有管理ファイルではなく、プロジェクト内の入口と上書き用ファイルです。共通本文は `.shared/docs/rules-*.md` に同期されます。

## 共有 skill の有効化

共有skillの正本は `.shared/skills/` のvendorコピーです。CodexやClaude Codeの標準探索先へは実体コピーを置かず、必要に応じてリンクを生成します。

```powershell
scripts/setup-agent-skill-links.ps1
```

このスクリプトは `.shared/skills/*/SKILL.md` を候補として扱い、Codex用に `.agents/skills/<skill-name>`、Claude Code用に `.claude/skills/<skill-name>` を作ります。可能なら相対シンボリックリンクを作り、Windowsで作れない場合はjunctionにフォールバックします。

生成されたリンクは環境依存のためGit管理しません。スクリプトは生成したリンクパスを `.git/info/exclude` に追加します。既存パスが正しいリンクなら何もせず、実ディレクトリや別ターゲットのリンクがある場合は上書きせず警告します。

## 同期

```powershell
scripts/sync-shared-reference.ps1 -Ref <shared-reference-commit>
```

同期結果は `.shared/shared-reference.lock.yaml` に記録します。共有管理ファイルにローカル変更がある場合、同期は停止します。

## 正本への変更提案

```powershell
scripts/propose-shared-reference-change.ps1 -VendorPath .shared/skills/skills-index.md
```

このコマンドは、vendorコピーに対応する `shared-reference` 側の正本ファイルを表示します。正本側で編集、commit、pushしたあと、このプロジェクトで同期します。
