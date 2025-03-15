# Custardファイルの作り方

カスタードファイルはjson形式のデータです。拡張子は`txt`, `json`, `custard`のうちどれかである必要があります。

## サンプル

以下のコマンドでサンプルを実行できます。

```bash
swift run samples hieroglyphs
```

これを実行すると`results/hieroglyphs.json`が作られます。

## キーの記述

キーボードでキーは最も大切な要素です。CustardKitではキーは次のように記述します。

```Swift
let key = CustardInterfaceCustomKey(
    design: .init(label: .text("@#/&_"), color: .normal),
    press_actions: [.input("@")],
    longpress_actions: .none,
    variations: []  
)
```

このデータは

* ラベルが「@#/&_」であり
* 色は普通のキーと同じであり
* 押すと「@」を入力し
* 長押ししても何もせず
* フリックや長押しによる候補変更は行われない

キーを表現しています。順番に見てみましょう。

### デザイン

最初の引数は`design`です。これは`CustardKeyDesign`型の値で、キーのデザインを指定します。簡潔さのため型名を省略して記述しています。

```swift
design: .init(label: .text("@#/&_"), color: .normal)
```

引数`label`はキーに表示されるラベルです。ラベルに指定できる値は次の通りです。

| 項目                 | 説明                                                         |
| -------------------- | ------------------------------------------------------------ |
| .text(String)        | 指定した文字をラベルとして表示します。                       |
| .mainAndSub(String, String) | 1つ目に指定した1文字を1行目に大きめに、2つ目に指定した文字を2行目に小さめに表示します。 |
| .systemImage(String) | 指定した名前の画像をラベルとして表示します。指定できる値は以下の通りです。<br />この画像はSFSymbolsから取得されます。 |

<img src="../resource/symbols.png" style="zoom:15%;" />

引数`color`はキーの色です。azooKeyは着せ替えに対応しているため、キーの色は環境によって変わります。以下の値を指定できます。

| 識別子    | 説明                                     |
| --------- | ---------------------------------------- |
| .normal   | 通常の入力キーの色です。                 |
| .special  | タブ移動キーや削除キーの色です。         |
| .selected | 選択中のタブや押されているキーの色です。 |
| .unimportant | 重要度の低いキーの色です。 |

### アクション

次の引数は`press_actions`です。これはキーを単純に押した際のアクションの配列です。キーを押して離した段階で、配列の順序で動作が実行されます。

アクションは`CodableActionData`という列挙型の値です。例えば以下のように記述されています。

```Swift
press_actions: [
  .input("@")
]
```

この動作は「@を入力する」に対応するものです。

azooKeyでは`input`の他にいくつかの動作を行うことができます。Associated Valueの方については後述します。

| Value                  | Associated Value | 挙動                                                         |
| :--------------------- | :--------------- | :----------------------------------------------------------- |
| .input                 | String           | 引数を入力します                                             |
| .delete                | Int              | 引数の分だけ文字を削除します。負の値が指定されている場合は文末方向に削除します。 |
| .moveCursor            | Int              | 引数の分だけカーソルを移動します。負の値が指定されている場合は文頭方向に移動します。 |
| .moveTab               | CodableTabData   | 引数で指定したタブに移動します。                             |
| .selectCandidate       | CandidateSelection | 引数で指定した候補を選択状態にします                       |
| .complete              | なし              | 変換を確定します                                          |
| .replaceLastCharacters | [String: String] | カーソル文頭方向の文字列を引数に基づいて置換します。例えばカーソル文頭方向の文字列が`"abcdef"`であり、テーブルに`"def":":="`が指定されている場合は`"abc:="`と置換されます。 |
| .replaceDefault        | なし             | azooKeyが標準で用いている「濁点・半濁点・小書き・大文字・小文字」の切り替えアクションです。 |
| .smartDelete           | ScanItem         | 引数で指定した方向に、指定した文字を見つけるまで削除を繰り返します。例えば文頭方向の文字列が`"Yes, it is"`であり、方向が`.backward`かつ文字の指定が` [","]`であった場合、この操作の実行後に`" it is"`が削除されます。 |
| .smartDeleteDefault    | なし             | azooKeyが標準で用いている「文頭まで削除」のアクションです。  |
| .smartMoveCursor       | ScanItem         | 引数で指定した方向に、指定した文字を見つけるまで移動を繰り返します。例えば文頭方向の文字列が`"Yes, it is"`であり、方向が`.backward`かつ文字の指定が` [","]`であった場合、この操作の実行後に`"Yes,| it is"`まで移動します。 |
| .enableResizingMode    | なし             | 片手モードの編集状態に移動します。編集状態ではキー操作などが行えないため、.disableResizingModeは用意されていません。 |
| .toggleCursorBar       | なし             | カーソルバーの表示をtoggleします。                           |
| .toggleTabBar          | なし             | タブバーの表示をtoggleします。                               |
| .toggleCapsLockState   | なし             | caps lockをtoggleします。                                    |
| .dismissKeyboard       | なし             | キーボードを閉じます。                                       |
| .paste                 | なし             | コピーしている文字列をペーストします。フルアクセスがない場合動作しません。  |
| .launchApplication     | LaunchItem       | 引数で指定されたアプリケーションを開きます。 |

続く引数の`longpress_actions`は`CodableLongpressActionData`型の値です。定義は以下の通りで、`start`と`repeat`にそれぞれ行うべき動作を指定します。

```Swift
struct CodableLongpressActionData{
    var start: [CodableActionData]
    var `repeat`: [CodableActionData]
}
```

ここで`start`は長押しの開始時に一度だけ実行される動作、`repeat`は長押しの間繰り返し実行される動作です。それぞれ上で書いたものと同様にアクションの配列を指定します。

特に長押しにおいて動作を行わせない場合は`.none`を指定します。これは`start`と`repeat`にともに空の配列を指定したものです。

#### CodableTabData

以下で定義される列挙型です。

```Swift
enum CodableTabData{
    case system(SystemTab)
    case custom(String)

    enum SystemTab {
        case user_japanese
        case user_english
        case flick_japanese
        case flick_english
        case flick_numbersymbols
        case qwerty_japanese
        case qwerty_english
        case qwerty_numbers
        case qwerty_symbols
        case last_tab
    }
}
```

`SystemTab`として指定できる値は以下の通りです。

| 識別子               | 説明                                                         |
| -------------------- | ------------------------------------------------------------ |
| .user_japanese       | ユーザの設定に合わせた日本語タブ                             |
| .user_english        | ユーザの設定に合わせた英語タブ                               |
| .flick_japanese      | フリック入力の日本語タブ                                     |
| .flick_english       | フリック入力の英語タブ                                       |
| .flick_numbersymbols | フリック入力の数字・記号タブ                                 |
| .qwerty_japanese[^2] | ローマ字入力の日本語タブ                                     |
| .qwerty_english[^2]  | ローマ字入力の英語タブ                                       |
| .qwerty_number[^2]   | ローマ字入力の数字タブ                                       |
| .qwerty_symbols[^2]  | ローマ字入力の記号タブ                                       |
| .emoji_tab           | 絵文字タブ                                                |
| .clipboard_history_tab | クリップボードの履歴タブ(フルアクセスが必要です)               |
| .last_tab            | このタブの前のタブ<br />もしも履歴がない場合、現在のタブの指定になります |

### ScanItem

以下で定義される構造体です。

```Swift
struct ScanItem{
    let targets: [String]
    let direction: Direction

    enum Direction {
        case forward
        case backward
    }
}
```

### バリエーション

バリエーションは「メインとなるキーに付随して選択可能な別種のキー」のことです。簡単にはフリック入力における上下左右に現れるキー、あるいはローマ字入力において長押しで選択できる候補のことを指しています。`variations`にはバリエーションの配列を指定します。

上のキーではバリエーションは指定していませんが、実際にバリエーションを作る際は次のように書きます。

```Swift
variations: [
    .init(
        type: .flickVariation(.left),
        key: .init(
            design: .init(label: .text("#")),
            press_actions: [.input("#")],
            longpress_actions: .none
        )
    ),
    .init(
        type: .flickVariation(.top),
        key: .init(
            design: .init(label: .text("/")),
            press_actions: [.input("/")],
            longpress_actions: .none
        )
    ),
]
```

少し長いですが、中身はここまでみてきたキーとほぼ変わりません。違いは

* デザインの指定が`label`のみであり
* `variations`の指定がなく
* `type`の指定がある

ことです。

`type`はそのバリエーションの種類です。

| Value                   | Associated Value | 説明                                                         |
| ----------------------- | ---------------- | ------------------------------------------------------------ |
| .flickVariation         | FlickDirection   | directionとして指定する`.left, .top, .right, .bottom`の方向のフリックで表示されるバリエーションです。 |
| .longpressVariation[^3] | なし             | qwertyキーボードなどで見られる長押しして表示される候補のバリエーションです。配列に指定した順に表示されます。<br />これが指定されている場合、キーの`longpress_actions`に指定した値は無視されます。またバリエーションの`longpress_actions`は現状無効です。 |

以上でキーの記述の説明は終わりです。

## インターフェースの記述

インターフェースとはキーを含む画面全体のことです。例えば以下のような形をしています。

```Swift
interface: .init(
    keyStyle: .tenkeyStyle,
    keyLayout: .gridFit(.init(rowCount: 5, columnCount: 4)),
    keys: [
         .gridFit(.init(x: 0, y: 1)): .custom(キーのデータ)
    ]
)
```

### レイアウト

`keyLayout`とはキーを配置する方法です。`.gridFit`または`.gridScroll`を選ぶことができます。

| Value       | Associated Value                                             | 説明                                                         |
| ----------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| .gridFit    | rowCount: int<br />columnCount: int                          | 画面全体に収まるように格子状にキーを配置するレイアウトです。横にrowCount個、縦にcolumnCount個のキーを並べます。 |
| .gridScroll | direction: str<br />rowCount: double<br />columnCount: double | 画面をスクロールできる状態にして格子状にキーを配置するレイアウトです。<br />スクロールの方向を示すdirectionには`.vertical`または`.horizontal`を指定し、rowCountとcolumnCountを指定します。<br />スクロール方向に垂直な向きのキー数は切り捨てて整数として利用されますが、平行な向きのキー数は小数のまま用います。<br />このレイアウトが指定されている場合、キーの`variations`は一切無効になります。 |

### スタイル

`keyStyle`は処理系にどのようにキーを扱えばいいかを知らせるための値です。`tenkeyStyle`または`pcStyle`を指定してください。

片手モードの状態は端末の向きとスタイルによって決まります。レイアウトが`gridScroll`である場合はフリック操作とサジェストは無効化されます。

| スタイル     | 説明                                                         |
| ------------ | ------------------------------------------------------------ |
| .tenkeyStyle | 携帯打ちやフリック式のかな入力、九宮格輸入法などで用いられる、10キーを模した形状のキーボードに対して指定してください。<br />variationはflickVariationのみが有効になります。<br />縦方向のスペーシングは狭めになります。<br />サジェストはキーを長押しすると表示され、キーとflickVariationが表示されます。 |
| .pcStyle     | Qwerty配列やJisかな配列など、パソコンのキーボードを模した形状のキーボードに対して指定してください。<br />variationはlongpressVariationのみが有効になります。<br />縦方向のスペーシングは広めになります。<br />サジェストはキーを押すと表示され、押し続けるとlongpressVariationが表示されます。 |

### キー

`keys`とはキーのデータの辞書で`[CustardKeyPositionSpecifier: CustardInterfaceKey]`という型の値です。

`CustardKeyPositionSpecifier`は以下で定義されます。キーの位置を調整するために必要な値です。

```Swift
enum CustardKeyPositionSpecifier {
    case gridFit(GridFitPositionSpecifier)
    case gridScroll(GridScrollPositionSpecifier)
}
```

それぞれ以下のような型です。

| 型                          | 値                                                  | 説明                                                         |
| --------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| GridFitPositionSpecifier    | x: int<br />y: int<br />width: int<br />height: int | gridFitレイアウト上でキーをどの位置に配置するかを指定します。<br />キーの左上が(x, y)となり、widthとheightの分だけ縦横に広がります。<br />widthとheightは省略可能です。 |
| GridScrollPositionSpecifier | index: int                                          | gridScrollレイアウト上で最初から数えた順番を指定します。<br />0から順に指定し、間を開けてはいけません。<br />ExpressibleByIntegerLiteralに準拠しているので、単に.gridScroll(42)のように書いても問題ありません。 |

`CustardInterfaceKey`は以下で定義されます。キーの実体を示す値です。

```Swift
enum CustardInterfaceKey {
    case custom(CustardInterfaceCustomKey)
    case system(CustardInterfaceSystemKey)
}

enum CustardInterfaceSystemKey{
    case change_keyboard
    case enter
    case upper_lower
    case next_candidate
    case flick_kogaki
    case flick_kutoten
    case flick_hira_tab
    case flick_abc_tab
    case flick_star123_tab
}
```

`CustardInterfaceCustomKey`型は上で説明したキーのことです。また`CustardInterfaceSystemKey`型は特殊なキーを指定するための列挙型で、以下のような値を取ることができます。

| 識別子             | 説明                                                         |
| ------------------ | ------------------------------------------------------------ |
| .change_keyboard   | 地球儀キー(キーボード切り替えキー)。ホームボタンがない端末ではカーソルバーの表示キーに切り替わります。 |
| .enter             | 改行・確定キー。                                             |
| .upper_lower       | 大文字・小文字キー。                                          |
| .next_candidate    | 入力状態に応じて「空白」と「次候補」が切り替わるキー。               |
| .flick_kogaki      | ユーザがカスタムしている可能性のあるフリックの「小ﾞﾟ」キー。gridFitのtenkeyStyle以外での利用は非推奨。 |
| .flick_kutoten     | ユーザがカスタムしている可能性のあるフリックの「､｡?!」キー。gridFitのtenkeyStyle以外での利用は非推奨。 |
| .flick_hira_tab    | ユーザがカスタムしている可能性のあるフリックの「あいう」キー。gridFitのtenkeyStyle以外での利用は非推奨。 |
| .flick_abc_tab     | ユーザがカスタムしている可能性のあるフリックの「abc」キー。gridFitのtenkeyStyle以外での利用は非推奨。 |
| .flick_star123_tab | ユーザがカスタムしている可能性のあるフリックの「☆123」キー。gridFitのtenkeyStyle以外での利用は非推奨。 |

以上でインターフェースの記述の説明は終わりです。

## カスタードの記述

あと少しです！カスタードは以下のように記述します。

```Swift
let md_custard = Custard(
    identifier: "my_flick",
    language: .ja_JP,
    input_style: .direct,
    metadata: .init(custard_version: .v1_0, display_name: "私のフリック"),
    inteface: {インターフェースの記述}
)
```

`identifier`はカスタードを識別するための文字列です。他のものと被らない値を指定してください。

`language`は変換対象の言語です。以下の値が指定できます。

| 識別子     | 説明                                                 |
| ---------- | ---------------------------------------------------- |
| .ja_JP     | 日本語(共通語)                                       |
| .en_US     | 英語(アメリカ)                                       |
| .el_GR     | ギリシャ語                                           |
| .undefined | 指定なし。変換候補は出るので記号などの入力で用いる。 |
| .none      | 変換なし。                                           |

`input_style`は入力方式です。以下の値が指定できます。

| 識別子      | 説明                         |
| ----------- | ---------------------------- |
| .direct     | 入力をそのまま用います。     |
| .roman2kana | ローマ字かな入力を行います。 |

`metadata`は`CustardMetadata`型の値で、キーボードの動作とは無関係な情報を格納します。現在は以下の2つの値を指定してください。

* `custard_version`は規格のバージョン情報です。この資料に基づいて作成する場合`.v1_0`を指定してください。
* `display_name`はタブバーなどでデフォルトで用いられる名称です。

`interface`には上で記述したとおりのインターフェースの記述を行います。

### 複数のカスタードファイルを1つにまとめる

カスタードのデータを配列で指定することで、読み込み側が複数のファイルを一括で読み込めます。

```
[
  {カスタードの記述1},
  {カスタードの記述2},
  {カスタードの記述3},
]
```

以上でカスタードの記述の説明は終わりです。

## ツール

特定の状況でより簡単に記述するため、ユーティリティが用意されています。

### キーの作成

`CustomKey`には以下の2つの関数が用意されています。

```Swift
static func flickSimpleInputs(center: String, subs: [String], centerLabel: String? = nil) -> CustomKey

static func flickSimpleInputs(center: SimpleInputArgument, left: SimpleInputArgument? = nil, top: SimpleInputArgument? = nil, right: SimpleInputArgument? = nil, bottom: SimpleInputArgument? = nil) -> CustomKey
```

以下のように用いることができます。

`CustomKey.flickSimpleInputs`では、中心の文字とフリックで入力する文字を順番に指定することで`CustomKey`オブジェクトを作成します。以下のように用いることができます。

```Swift
let key: CustomKey = .flickSimpleInputs(center: "あ", subs: ["い", "う", "え", "お"], centerLabel: "あいう")
let key: CustomKey = .flickSimpleInputs(
    center: .init(label: "😸", input: ":smile_cat:"), 
    left: .init(label: "😿", input: ":crying_cat_face:"),
    right: .init(label: "😻", input: ":heart_eyes_cat:")
)
```

この関数では、ラベルと入力が同じ場合に指定を省略することができます。

```Swift
let key: CustomKey = .flickSimpleInputAndLab(
    center = .init(label: "あ", input: "あ゛"), 
    left = .init(label: "い", input: "い゛"),
    top = "ゔ",
    right = .init(label: "え", input: "え゛"),
    bottom = .init(label: "お", input: "お゛")
)
```

### 書き出し

書き出しのための関数が用意されています。

```Swift
//指定したpathにcustardファイルを書き出します
custard.write(to: path)
```

複数のCustardオブジェクトを1つのファイルとして書き出す場合は`[Custard]`に対して同様に書き出し関数を呼び出します。

```Swift
//指定したpathにcustardのリストのファイルを書き出します
custardList = [custard1, custard2, custard3].write(to: path)
```

## 用例

例としてUnicodeに登録されているヒエログリフを入力できるスクロール可能なタブを作りましょう。

```Swift
import CustardKit

//ヒエログリフのリストを取得
let hieroglyphs = String.UnicodeScalarView((UInt32(0x13000)...UInt32(0x133FF)).compactMap(UnicodeScalar.init)).map(String.init)

//キーの辞書を作成
var hieroglyphs_keys: [CustardKeyPositionSpecifier: CustardInterfaceKey] = [
    .gridScroll(0): .system(.change_keyboard),
    .gridScroll(1): .custom(
        .init(
            design: .init(label: .text("←"), color: .special),
            press_actions: [.moveCursor(-1)],
            longpress_actions: .init(repeat: [.moveCursor(-1)]),
            variations: []
        )
    ),
    .gridScroll(2): .custom(
        .init(
            design: .init(label: .text("→"), color: .special),
            press_actions: [.moveCursor(1)],
            longpress_actions: .init(repeat: [.moveCursor(1)]),
            variations: []
        )
    ),
    .gridScroll(3): .custom(
        .init(
            design: .init(label: .systemImage("list.bullet"), color: .special),
            press_actions: [.toggleTabBar],
            longpress_actions: .none,
            variations: []
        )
    ),
    .gridScroll(4): .custom(
        .init(
            design: .init(label: .systemImage("delete.left"), color: .special),
            press_actions: [.delete(1)],
            longpress_actions: .init(repeat: [.delete(1)]),
            variations: []
        )
    ),
]

//ヒエログリフの入力キーを順次追加
hieroglyphs.indices.forEach{
    hieroglyphs_keys[.gridScroll(GridScrollPositionSpecifier(hieroglyphs_keys.count))] = .custom(
        .init(
            design: .init(label: .text(hieroglyphs[$0]), color: .normal),
            press_actions: [.input(hieroglyphs[$0])],
            longpress_actions: .none,
            variations: []
        )
    )
}

//Custardを作成
let hieroglyphs_custard = Custard(
    identifier: "hieroglyphs",
    language: .none,
    input_style: .direct,
    metadata: .init(custard_version: .v1_0, display_name: "ヒエログリフ"),
    interface: .init(
        keyStyle: .tenkeyStyle,
        keyLayout: .gridScroll(.init(direction: .vertical, rowCount: 8, columnCount: 4.2)),
        keys: hieroglyphs_keys
    )
)

//書き出す
do {
    try hieroglyphs_custard.write(to: URL(fileURLWithPath: "hieroglyphs.json"))
} catch {
    print(error.localizedDescription)
}
```

---

[^2]: ここではpc_styleではなくqwertyと呼んでいます。これはこのタブの配列がqwertyであるからです。
[^3]:  ここではqwerty_variationあるいはpc_style_variationではなくlongpress_variationと呼んでいます。variationがそれが現れる条件となる操作によって分類されるからです。

