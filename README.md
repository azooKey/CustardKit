# CustardKit

![](https://api.travis-ci.org/ensan-hcl/CustardKit.svg?branch=main&status=unknown)
[![Swift](https://github.com/ensan-hcl/CustardKit/actions/workflows/swift.yml/badge.svg)](https://github.com/ensan-hcl/CustardKit/actions/workflows/swift.yml)

azookeyのカスタムタブのデータファイルを作成するための補助ツールです。

現在以下を含みます。

* Swift向け生成ツール
* JSON/Swiftドキュメント
  * [JSON用ドキュメント](./json/howToMake.md)
  * [Swift用ドキュメント](./swift/howToMake.md)

## Examples

CustardKitを用いてazooKeyで利用可能な様々なキーボードを作成することができます。このリポジトリに含まれるサンプルのスクリーンショットは以下の通りです。

| hieroglyphs<br /><img src="./resource/custard_hieroglyphs.jpg" alt="structure" style="zoom:50%;" /> | cuneiforms<br /><img src="./resource/custard_cuneiforms.jpg" alt="structure" style="zoom:50%;" /> | flick_greek<br /><img src="./resource/custard_flick_greek.jpg" alt="structure" style="zoom:50%;" /> |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| **tex_board**<br /><img src="./resource/custard_tex_board.jpg" alt="structure" style="zoom:50%;" /> | **number_font**<br /><img src="./resource/custard_number_font.jpg" alt="structure" style="zoom:50%;" /> | **md_keyboard_jp**<br /><img src="./resource/custard_markdown.jpg" alt="structure" style="zoom:50%;" /> |

## Structure of a keyboard

azooKeyではキーボードの構造を以下の図のように捉えています。

カスタムタブのデータファイルは主にインターフェースを記述するものです。

<img src="./resource/structure.png" alt="structure" style="zoom:50%;" />

## How to use generated file

1. [App Store](https://apps.apple.com/us/app/id1542709230)でazooKeyをインストールしてください。
2. 拡張→カスタムタブの管理→読み込む　より、作成したファイルを読み込んでください。
3. ファイルが読み込まれたら「保存」を押してください。
4. キーボード上で、何も入力していない状態で変換候補欄を長押しし、タブバーを表示してください。
5. 右にスクロールし、作成したファイルの名前をタップしてください。
6. カスタムタブが利用できます。

## License

MIT Licenseです。ご自由にご利用ください。
