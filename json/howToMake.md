# Custardファイルの作り方

カスタードファイルはJSON形式のデータです。拡張子は`txt`, `json`, `custard`のうちどれかである必要があります。

## キーの記述

キーボードでキーは最も大切な要素です。custardファイルではキーは次のように記述します。

```json
{
  "design": {
    "label": {
      "text": "@#/&_"
    },
    "color": "normal"
  },
  "press_actions": [
    {
      "type": "input",
      "text": "@"
    }
  ],
  "longpress_actions": {
    "start": [],
    "repeat": []
  },
  "variations": []
}
```

このデータは

* ラベルが「@#/&_」であり
* 色は普通のキーと同じであり
* 押すと「@」を入力し
* 長押ししても何もせず
* フリックや長押しによる候補変更は行われない

キーを表現しています。順番に見てみましょう。

### デザイン

最初は`"design"`です。これはキーのデザインを指定します。

```json
"design": {
  "label": {
    "type": "text",
    "text": "@#/&_"
  },
  "color": "normal"
}
```

`"label"`はキーに表示されるラベルです。ラベルに指定できる値は次の通りです。

| type              | 説明                                                         |
| ----------------- | ------------------------------------------------------------ |
| text              | `"text"`に指定した文字をラベルとして表示します。                       |
| main_and_sub      | `"main"`に指定した1文字を1行目に大きめに、`"sub"`に指定した文字列を2行目に小さめに表示します。 |
| system_image      | `"system_image"`に指定した画像をラベルとして表示します。指定できる値は以下の通りです。<br />この画像はSFSymbolsから取得されます。 |

<img src="../resource/symbols.png" style="zoom:15%;" />

`"color"`はキーの色です。azooKeyは着せ替えに対応しているため、キーの色は環境によって変わります。以下の値を指定できます。

| 識別子   | 説明                                     |
| -------- | ---------------------------------------- |
| normal   | 通常の入力キーの色です。                 |
| special  | タブ移動キーや削除キーの色です。         |
| selected | 選択中のタブや押されているキーの色です。 |
| unimportant | 重要度の低いキーの色です。 |

### アクション

次に来るのは`"press_actions"`です。これはキーを単純に押した際のアクションの配列です。キーを押して離した段階で、配列の順序で動作が実行されます。

アクションは例えば以下のように記述されています。

```json
{
  "type": "input",
  "text": "@"
}
```

`"type"`に対して`"input"`を指定することでこのアクションが`"input"`であることを指示し、引数`"text"`として`"@"`を指定することでその引数を表現します。この動作は「@を入力する」に対応するものです。

azooKeyでは`"input"`の他にいくつかの動作を行うことができます。

| 識別子                  | 項目                               | 挙動                                                         |
| :---------------------- | :--------------------------------- | :----------------------------------------------------------- |
| input                   | text: str                          | 引数textを入力します                                         |
| delete                  | count: int                         | (countの絶対値)文字を削除します。負の値が指定されている場合は文末方向に削除します。 |
| move_cursor             | count: int                         | (countの絶対値)文字分カーソルを移動します。負の値が指定されている場合は文頭方向に移動します。 |
| move_tab                | tab_type: str<br />identifier: str | identifierで指定したタブに移動します。tab_typeが`"system"`の場合はazooKeyが標準で搭載しているタブに移動し、`"custom"`の場合はidentifierを持ったカスタムタブに移動します。システムタブとして指定できる値は後に記述します。 |
| select_candidate       | type: str<br /> value: int          | 引数で指定した候補を選択状態にします。typeは4種類あります。`"first"`（最初の候補）と`"last"`（最後の候補）の場合は`"value"`の指定は不要です。`"exact"`（value個目の候補を選択）と`"offset"`（value個隣の候補を選択）の場合は`"value"`に数値を指定してください。 |
| complete              | なし              | 変換を確定します                                          |
| replace_last_characters | table: {str: str}                  | カーソル文頭方向の文字列を引数のtableに基づいて置換します。例えばカーソル文頭方向の文字列が`"abcdef"`であり、テーブルに`"def":":="`が指定されている場合は`"abc:="`と置換されます。 |
| replace_default         | なし                               | azooKeyが標準で用いている「濁点・半濁点・小書き・大文字・小文字」の切り替えアクションです。 |
| transliterate         | kana: str                            | 入力の仮名文字を全てhiragana/katakana/hankakukatakanaのいずれかで置き換えます。 |
| smart_delete            | direction: str<br />targets: [str] | directionに`"forward"`または`"backward"`を指定します。targetsに指定した文字のいずれかがカーソル進行方向に現れるまで削除を繰り返します。例えば文頭方向の文字列が`"Yes, it is"`であり、`"direction": "backward", "targets": [","]`であった場合、この操作の実行後に`" it is"`が削除されます。 |
| smart_delete_default    | なし                               | azooKeyが標準で用いている「文頭まで削除」のアクションです。  |
| smart_move_cursor       | direction: str<br />targets: [str] | directionに`"forward"`または`"backward"`を指定します。targetsに指定した文字のいずれかがカーソル進行方向に現れるまでカーソルの移動を繰り返します。例えば文頭方向の文字列が`"Yes, it is"`であり、`"direction": "backward", "target": [","]`であった場合、この操作の実行後にカーソルが`"Yes,| it is"`まで移動します。 |
| enable_resizing_mode    | なし                               | 片手モードの編集状態に移動します。編集状態ではキー操作などが行えないため、disable_resizing_modeは用意されていません。 |
| toggle_cursor_bar       | なし                               | カーソルバーの表示をtoggleします。                           |
| toggle_tab_bar          | なし                               | タブバーの表示をtoggleします。                               |
| toggle_caps_lock_state  | なし                               | caps lockをtoggleします。                                    |
| dismiss_keyboard        | なし                               | キーボードを閉じます。                                       |
| paste                   | なし                               | コピーしている文字列をペーストします。フルアクセスがない場合動作しません。  |
| launch_application      | scheme_type: str<br />target: str | scheme_typeで指定されたアプリケーションをscheme://(target)として開きます。scheme_typeには`"azooKey"`か`"shortcuts"`のみを指定できます。 |

続く`"longpress_actions"`はほぼ`"press_actions"`と同じです。

```json
"longpress_actions": {
  "start": [],
  "repeat": []
}
```

ここで`"start"`は長押しの開始時に一度だけ実行される動作、`"repeat"`は長押しの間繰り返し実行される動作です。それぞれ上で書いたものと同様にアクションの配列を指定します。

#### システムタブ

| 識別子              | 説明                                                         |
| ------------------- | ------------------------------------------------------------ |
| user_japanese       | ユーザの設定に合わせた日本語タブ                             |
| user_english        | ユーザの設定に合わせた英語タブ                               |
| flick_japanese      | フリック入力の日本語タブ                                     |
| flick_english       | フリック入力の英語タブ                                       |
| flick_numbersymbols | フリック入力の数字・記号タブ                                 |
| qwerty_japanese[^2] | ローマ字入力の日本語タブ                                     |
| qwerty_english[^2]  | ローマ字入力の英語タブ                                       |
| qwerty_number[^2]   | ローマ字入力の数字タブ                                       |
| qwerty_symbols[^2]  | ローマ字入力の記号タブ                                       |
| emoji_tab           | 絵文字タブ                                                |
| clipboard_history_tab | クリップボードの履歴タブ(フルアクセスが必要です)               |
| last_tab            | このタブの前のタブ<br />もしも履歴がない場合、現在のタブの指定になります |

### バリエーション

バリエーションは「メインとなるキーに付随して選択可能な別種のキー」のことです。簡単にはフリック入力における上下左右に現れるキー、あるいはローマ字入力において長押しで選択できる候補のことを指しています。`"variations"`にはバリエーションの配列を指定します。

上のキーではバリエーションは指定していませんが、実際にバリエーションを作る際は次のように書きます。

```json
"variations": [
  {
    "type": "flick_variation",
    "direction": "left",
    "key": {
      "design": {
        "label": {
          "text": "#"
        }
      },      
      "press_actions": [
        {
          "type": "input",
          "text": "#"
        }
      ],
      "longpress_actions": {
        "start": [],
        "repeat": []
      }
    }
  },
  {
    "type": "flick_variation",
    "direction": "top",
    "key": {
      "design": {
        "label": {
          "text": "/"
        }
      },
      "press_actions": [
        {
          "type": "input",
          "text": "/"
        }
      ],
      "longpress_actions": {
        "start": [],
        "repeat": []
      }
    }
  }
]
```

少し長いですが、中身はここまでみてきたキーとほぼ変わりません。違いは

* デザインの指定がラベルのみであり
* `"variations"`の指定がなく
* `"type"`と`"direction"`の指定がある

ことです。

`"type"`はそのバリエーションの種類です。

| タイプ                  | 項目           | 説明                                                         |
| ----------------------- | -------------- | ------------------------------------------------------------ |
| flick_variation         | direction: str | directionとして指定する`"left","top","right","bottom"`の方向のフリックで表示されるバリエーションです。 |
| longpress_variation[^3] | なし           | qwertyキーボードなどで見られる長押しして表示される候補のバリエーションです。配列に指定した順に表示されます。<br />これが指定されている場合、キーの`"longpress_actions"`に指定した値は無視されます。またバリエーションの`"longpress_actions"`は現状無効です。 |

以下は例です。

```json
//typeがflick_variationの場合
{
    "type": "flick_variation",
    "direction": "left",
    "key": {}
}

//typeがlongpress_variationの場合
{
    "type": "longpress_variation",
    "key": {}
}
```

以上でキーの記述の説明は終わりです。

## インターフェースの記述

インターフェースとはキーを含む画面全体のことです。例えば以下のような形をしています。

```json
{
  "key_layout": {
    "type": "grid_fit",
    "row_count": 5,
    "column_count": 4
  },
  "key_style": "tenkey_style",
  "keys": [
    {
      "specifier_type": "grid_fit",
      "specifier": {
        "x": 1,
        "y": 0
      },
      "key_type": "custom",
      "key": {キーのデータ}
    },
    (省略)
  ]
}
```

### レイアウト

`"key_layout"`とはキーを配置する方法です。typeには`"grid_fit"`または`"grid_scroll"`を選ぶことができます。

| 識別子      | 項目                                                         | 説明                                                         |
| ----------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| grid_fit    | row_count: int<br />column_count: int                        | 画面全体に収まるように格子状にキーを配置するレイアウトです。横にrow_count個、縦にcolumn_count個のキーを並べます。 |
| grid_scroll | direction: str<br />row_count: double<br />column_count: double | 画面をスクロールできる状態にして格子状にキーを配置するレイアウトです。<br />スクロールの方向を示すdirectionには`"vertical"`または`"horizontal"`を指定し、row_countとcolumn_countを指定します。<br />スクロール方向に垂直な向きのキー数は切り捨てて整数として利用されますが、平行な向きのキー数は小数のまま用います。<br />このレイアウトが指定されている場合、キーの`"variations"`は一切無効になります。 |

### スタイル

処理系にどのようにキーを扱えばいいかを知らせるための値です。`"tenkey_style"`または`"pc_style"`を指定してください。

片手モードの状態は端末の向きとスタイルによって決まります。レイアウトが`"grid_scroll"`である場合はフリック操作とサジェストは無効化されます。

| スタイル     | 説明                                                         |
| ------------ | ------------------------------------------------------------ |
| tenkey_style | 携帯打ちやフリック式のかな入力、九宮格輸入法などで用いられる、10キーを模した形状のキーボードに対して指定してください。<br />variationはflick_variationのみが有効になります。<br />縦方向のスペーシングは狭めになります。<br />サジェストはキーを長押しすると表示され、キーとflick_variationが表示されます。 |
| pc_style     | Qwerty配列やJisかな配列など、パソコンのキーボードを模した形状のキーボードに対して指定してください。<br />variationはlongpress_variationのみが有効になります。<br />縦方向のスペーシングは広めになります。<br />サジェストはキーを押すと表示され、押し続けるとlongpress_variationが表示されます。 |

### キー

`"keys"`とはキーのデータの配列です。ここには以下のような形のオブジェクトが入ります。

```json
{
  "specifier_type": "grid_fit",
  "specifier": {
    "x": 1,
    "y": 0,
    "width": 1,
    "height": 1
  },
  "key_type": "custom",
  "key": {キーのデータ}
}
```

`"specifier"`はキーの位置を調整するために必要な値で、`"specifier_type"`はレイアウトで設定した値に基づきその種類を指定しています。

| 識別子      | 項目                                                | 説明                                                         |
| ----------- | --------------------------------------------------- | ------------------------------------------------------------ |
| grid_fit    | x: int<br />y: int<br />width: int<br />height: int | grid_fitレイアウト上でキーをどの位置に配置するかを指定します。<br />キーの左上が(x, y)となり、widthとheightの分だけ縦横に広がります。<br /> |
| grid_scroll | index: int                                          | grid_scrollレイアウト上で最初から数えた順番を指定します。<br />0から順に指定し、間を開けてはいけません。 |

以下は例です。

```json
//specifier_typeがgrid_fitの場合
"specifier_type": "grid_fit",
"specifier": {
  "x": 1,
  "y": 0,
  "width": 1,
  "height": 1
}

//specifier_typeがgrid_scrollの場合
"specifier_type": "grid_scroll",
"specifier": {
  "index": 42,
}
```

`"key_type"`はキーの種類を指定する値で、`"system"`または`"custom"`を指定します。

```json
//key_typeがsystemの場合
"key_type": "system",
"key": {
    "type": "enter"
}

//key_typeがcustomの場合
"key_type": "custom",
"key": {キーのデータ}
```

`"system"`の`"type"`として指定できる値は以下の通りです。

| 識別子            | 説明                                                         |
| ----------------- | ------------------------------------------------------------ |
| change_keyboard   | 地球儀キー(キーボード切り替えキー)。ホームボタンがない端末ではカーソルバーの表示キーに切り替わります。 |
| enter             | 改行・確定キー。                                             |
| upper_lower       | 大文字・小文字キー。                                          |
| next_candidate    | 入力状態に応じて「空白」と「次候補」が切り替わるキー。               |
| flick_kogaki      | ユーザがカスタムしている可能性のあるフリックの「小ﾞﾟ」キー。grid_fitのtenkey_style以外での利用は非推奨。 |
| flick_kutoten     | ユーザがカスタムしている可能性のあるフリックの「､｡?!」キー。grid_fitのtenkey_style以外での利用は非推奨。 |
| flick_hira_tab    | ユーザがカスタムしている可能性のあるフリックの「あいう」キー。grid_fitのtenkey_style以外での利用は非推奨。 |
| flick_abc_tab     | ユーザがカスタムしている可能性のあるフリックの「abc」キー。grid_fitのtenkey_style以外での利用は非推奨。 |
| flick_star123_tab | ユーザがカスタムしている可能性のあるフリックの「☆123」キー。grid_fitのtenkey_style以外での利用は非推奨。 |

以上でインターフェースの記述の説明は終わりです。

## カスタードの記述

あと少しです！カスタードは以下のように記述します。

```json
{
  "identifier": "my_flick",
  "language": "ja_JP",
  "input_style": "direct",
  "metadata": {
    "custard_version": "1.0",
    "display_name": "私のフリック",
  },
  "interface": {インターフェースの記述}
}
```

`"identifier"`はカスタードを識別するための文字列です。他のものと被らない値を指定してください。

`"language"`は変換対象の言語です。以下の値が指定できます。

| 識別子    | 説明                                                 |
| --------- | ---------------------------------------------------- |
| ja_JP     | 日本語(共通語)                                       |
| en_US     | 英語(アメリカ)                                       |
| el_GR     | ギリシャ語                                           |
| undefined | 指定なし。変換候補は出るので記号などの入力で用いる。 |
| none      | 変換なし。                                           |

`"input_style"`は入力方式です。以下の値が指定できます。

| 識別子     | 説明                         |
| ---------- | ---------------------------- |
| direct     | 入力をそのまま用います。     |
| roman2kana | ローマ字かな入力を行います。 |

`"metadata"`にはキーボードの動作とは無関係な情報を含めます。現在は以下の2つの値を指定してください。

* `"custard_version"`は規格のバージョン情報です。この資料に基づいて作成する場合`"1.0"`を指定してください。
* `"display_name"`はタブバーなどでデフォルトで用いられる名称です。

`"interface"`には上で記述したとおりのインターフェースの記述を行います。

### 複数のカスタードファイルを1つにまとめる

カスタードのデータを配列で指定することで、読み込み側が複数のファイルを一括でに読み込めます。

```
[
  {カスタードの記述1},
  {カスタードの記述2},
  {カスタードの記述3},
]
```

---

以上でカスタードの記述の説明は終わりです。

## コードを通して生成する

とはいえ、以上を全て手で書くのは骨の折れる作業です。そこでコードを通して生成するためのツールを用意しました。PythonまたはSwiftでカスタードオブジェクトを記述し、それをJSONとして書き出すことでカスタードファイルを作成することができます。この方法の場合、

* エディタであれば補完がきいて書きやすい
* 間違った構造はコードの時点でエラーになるので事前にわかる
* 繰り返し処理などを用いてより簡単にデータを生成できる

などの利点があります。

一部の構造はJSONと異なりますが、基本的にJSONを意識する必要はありません。

例としてUnicodeに登録されているヒエログリフを入力できるスクロール可能なタブを作りましょう。Swiftであれば以下のように書くことができます。これはJSONを手書きするよりもずっと簡単です。

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

SwiftまたはPythonでファイルを生成するには、以下のドキュメントを参照してください。

* [Swift用ドキュメント](../swift/howToMake.md)
* [Python用ドキュメント](../python/howToMake.md)

---

[^2]: ここではpc_styleではなくqwertyと呼んでいます。これはこのタブの配列がqwertyであるからです。
[^3]:  ここではqwerty_variationあるいはpc_style_variationではなくlongpress_variationと呼んでいます。variationがそれが現れる条件となる操作によって分類されるからです。

