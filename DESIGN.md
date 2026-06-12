# Design Direction

この文書は、UIや体験を持つコピー後プロジェクトのデザイン方向を整理するためのテンプレートです。機能要件の正本は `docs/project-spec.md`、UX判断の共通ルールは `docs/rules-ux.md` を参照します。

テンプレート段階では、特定の見た目、配色、コンポーネント、画面構成を固定しません。コピー後プロジェクトで、必要な範囲だけ具体化します。

## 1. Design Goal
- ユーザーに感じてほしいこと:
- 最も大事にする体験:
- 避けたい体験:

## 2. Audience
- 主なユーザー:
- 利用シーン:
- 利用頻度:
- デバイスや環境:

## 3. Product Tone
- 印象:
- 情報密度:
- 操作感:
- 文体:

## 4. Visual Direction
- 参考にしたい雰囲気:
- 配色方針:
- タイポグラフィ方針:
- アイコンやイラストの扱い:
- 余白やレイアウトの方針:

## 5. Core Screens
最初に作る代表画面を記載します。

| Screen | Purpose | Primary Action | Notes |
| --- | --- | --- | --- |
|  |  |  |  |

## 6. Components
繰り返し使うUI部品が見えてきたら記載します。

- Buttons:
- Forms:
- Navigation:
- Cards / Lists:
- Modals / Popovers:
- Feedback:

## 7. States
主要画面やコンポーネントで必要な状態を記載します。

- Loading:
- Empty:
- Error:
- Success:
- Disabled:
- Selected:

## 8. Do Not
複数のAIエージェントやデザインツールで作業しても避けたい方向を記載します。

- 

## 9. Handoff Notes
- Stitch、Figma、Canvaなどへ渡すときは、上記の方向、代表画面、避けたい方向を短くまとめる。
- 実装へ渡すときは、画面ごとの目的、主要アクション、状態設計を `docs/project-spec.md` と矛盾しない形で確認する。
- 決まっていないことは仮決定として扱い、正本へ反映する前に見直す。
