# DESIGN.md

This file defines portable design direction for AI design and coding agents.
Product requirements and expected behavior live in `docs/project-spec.md`.
UX principles and review criteria live in `docs/rules-ux.md`.

## 1. Product Context
- Product: ナンバータイル（旧作業名: 計算パネルパズル）
- Audience: 短時間で遊べる数字パズルや脳トレを好むスマホユーザー
- Primary user goal: 限られた数字タイルを配分し、すべてのゴール数字を成立させる
- Business objective: 広告付きスマホカジュアルゲームとして継続プレイされる体験を作る
- Desired user feeling: 明るい盤面で、数字タイルを気持ちよく割り振り、解けるとすっきりする
- Design maturity: draft

## 2. Design Direction
- Overall tone: 明るいタイルパズル、軽快、カジュアル
- Visual keywords: 数字タイル、ゴールスロット、盤面、手札、強い正解演出、縦画面
- Interaction keywords: タップだけ、即時反応、タイルが収まる感覚、短いステージ、リトライしやすい
- Reference products: 数字タイルパズル、ボードゲーム風パズル、短時間スマホパズル
- Avoid: 計算ドリル感、電卓道具感、長い説明文、細かすぎる入力、反応の遅い演出

## 3. Do Not
- Do not use: 手入力の数値キーボードを主操作にしない
- Avoid visual patterns: 学習教材風の堅い紙面、情報を詰め込んだ表、過剰な装飾
- Avoid interaction patterns: ドラッグ必須、長押し必須、確認ダイアログ多用
- Never change without updating this file: タイルパズルの中心トーン、タップだけで遊ぶ前提、縦固定の画面構成
- Out of scope for design agents: ランキング、デイリー、大量スキン、課金画面の詳細

## 4. Experience Principles
- Primary screen goal: 選択中ゴールに対して、今あるタイルで組み合わせを作る
- Information priority: 残りミス、ゴール、現在の組み合わせ、使用可能タイル、補助操作の順に分かる
- Navigation principle: 1ステージ中はゲーム画面に集中し、ホームや設定への導線は控えめにする
- Feedback principle: タップ、組み合わせ完成、正解、ミス、タイル消費を即時に見せる
- Error recovery principle: ミス後も選択状態を理解しやすくし、リトライや広告復活に迷わせない

## 5. Visual System

### Color
- Primary: タイルやゴールが目立つ明るいアクセント色
- Secondary: 演算子や補助操作用の落ち着いたアクセント色
- Background: 数字が読みやすい低ノイズ背景
- Surface: タイルと表示領域が明確に分かれる面
- Text: 数字の視認性を最優先
- Border: タイルの押せる領域が分かる程度
- Success: 正解時に強く光る色
- Warning: 残りミスや復活導線に使う色
- Error: ミス時に短く伝わる色

### Typography
- Font direction: 数字が読みやすいサンセリフ
- Heading style: 短く、ゲーム内状態が分かるサイズ
- Body style: 説明よりラベル中心
- Label style: 小さくても読める太さ
- Number/data style: タイル上で読みやすい大きな数字表現

### Spacing
- Base spacing: 親指で押しやすい間隔
- Section spacing: ゴール、組み合わせ、タイルを明確に分ける
- Dense areas: タイルグリッド
- Relaxed areas: ホーム、クリア、ゲームオーバー

### Shape
- Border radius: 押せるキーとして自然な丸み
- Card shape: 画面全体をカードだらけにせず、必要な情報ブロックに限定
- Button shape: タイルとボタンの役割が区別できる形
- Input shape: 数字入力欄ではなく、現在の式表示として扱う

### Elevation
- Default: タイルの押せる感じが分かる軽い奥行き
- Hover/focus: モバイル中心のためタップ/選択状態を優先
- Modal/dialog: クリア、ゲームオーバー、復活確認で限定的に使う
- Avoid: 重すぎる影、視認性を落とすぼかし

## 6. Component Rules

### Buttons
- Primary: スタート、次へ、リトライなど状態を進める操作
- Secondary: ホームへ戻る、設定など補助操作
- Destructive: ステージ中断など取り消しにくい操作
- Disabled: 選べない理由が状態で分かる見た目
- Loading: 広告や画面遷移中は連打を防ぐ

### Panels
- Number panel: 数字を大きく表示し、使用済みは押せない状態にする
- Operator panel: 数字と同じ操作感を保ちつつ、演算子として見分けやすくする
- Selected panel: 現在の式に入ったことが即座に分かる
- Consumed tile: 消費済みであることを明確にし、他ゴールで再利用できないことを伝える

### Status Displays
- Targets: 未クリア、選択中、クリア済みを一目で区別する
- Expression: `number operator number` の組み立て状態を、タイルを置くトレイとして中央で見せる
- Mistakes: 残り回数を小さくても常時確認できる

### Navigation
- Global navigation: ホームを起点にする
- Local navigation: ステージ中は戻る、リセット、ヒントなどを補助操作に置く
- Breadcrumbs/tabs: MVPでは不要

## 7. Screen Patterns

### Home
- User goal: ゲームを始める
- Primary action: スタート
- Key information: タイトル、進行状況、設定導線
- Layout: 縦画面で中央に主要アクションを置く
- Empty state: 初回でもそのままスタートできる
- Success state: ステージへ遷移する

### Game
- User goal: タイルを選んでゴールを成立させる
- Primary action: タイル選択
- Key information: ステージ情報、残りミス、ゴール、現在の組み合わせ、使用可能タイル
- Layout: 上からステージ情報、ゴール、組み合わせ、タイル、補助操作
- Error state: ミス理由を短く表示し、次の操作を妨げない
- Success state: ゴールクリアとタイル消費を明確に見せる

### Clear
- User goal: 結果を確認し次へ進む
- Primary action: 次へ
- Key information: クリア演出、スコア、報酬候補
- Layout: 達成感を中央に出し、次の操作を分かりやすくする
- Success state: 次ステージへ遷移する

### Game Over
- User goal: 復活するか、やり直すかを選ぶ
- Primary action: 広告で復活またはリトライ
- Key information: 失敗理由、復活回数、リトライ導線
- Layout: 選択肢を少なくし、誤タップしにくくする
- Error state: 広告が使えない場合はリトライを主導線にする

## 8. Responsive Rules
- Mobile: 縦固定を前提に、親指で押しやすいタイルサイズを優先する
- Tablet: 余白を広げすぎず、中央のゲーム領域を保つ
- Desktop: 開発確認用として中央に縦長ビューを置く
- Wide desktop: MVPの主要対象外

## 9. Content Style
- Voice: 短く、ゲーム内状態がすぐ分かる
- Button labels: `スタート`, `次へ`, `リトライ`, `復活`
- Empty state copy: 説明より即開始できる導線を優先
- Error copy: `計算が違います`, `0で割れません`, `タイルが足りません` のように短くする
- Help text: 常時表示せず、必要な場面で短く出す

## 10. Stitch Prompt Block

Use this block when importing or prompting in Stitch.

```text
Create UI designs for:
Audience: smartphone casual puzzle players
Primary action: tap number and operator tiles to complete goal numbers
Desired feeling: tile-board-like, snappy, satisfying, easy to understand
Visual direction: bright tile board, goal slots, tactile number tiles, vertical mobile layout
References: short-session number tile puzzle games, casual board puzzle games
Avoid: worksheet-like math drill, calculator-tool feeling, manual numeric input, long explanations
Important states: selected goal, tile combination building, consumed tile, correct answer, mistake, game over, rewarded revival
```

## 11. Review Checklist
- The game screen makes the current goal and available tiles obvious.
- The expression state is readable at a glance.
- Consumed tiles cannot be mistaken for usable tiles.
- Correct and mistake feedback is immediate.
- The design still works with one hand on a phone.
- The screen does not rely on long instructions to explain the rules.
