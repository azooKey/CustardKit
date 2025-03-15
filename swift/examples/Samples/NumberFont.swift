import Foundation
import CustardKit

extension Samples {
    func makeNumberFontTab() {
        func pcStyleInputKeys(_ char: String) -> CustardInterfaceCustomKey {
            .init(
                design: .init(label: .text(char), color: .normal),
                press_actions: [.input(char)],
                longpress_actions: .none,
                variations: []
            )
        }

        var numberkeys: [CustardKeyPositionSpecifier: CustardInterfaceKey] = [:]
        let numbers = [
            Array("1234567890"),
            Array("①②③④⑤⑥⑦⑧⑨⓪"),
            Array("𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡𝟘"),
            Array("𝟏𝟐𝟑𝟒𝟓𝟔𝟕𝟖𝟗𝟎")
        ]

        for i in numbers.indices {
            for j in numbers[i].indices {
                let (x, y) = (j, i)
                numberkeys[.gridFit(.init(x: x, y: y))] = .custom(pcStyleInputKeys(String(numbers[i][j])))
            }
        }

        numberkeys[.gridFit(.init(x: 0, y: 4))] = .custom(
            .init(
                design: .init(label: .systemImage("list.bullet"), color: .special),
                press_actions: [.toggleTabBar],
                longpress_actions: .none,
                variations: []
            )
        )

        numberkeys[.gridFit(.init(x: 1, y: 4))] = .system(.changeKeyboard)
        numberkeys[.gridFit(.init(x: 2, y: 4))] = .custom(
            .init(
                design: .init(label: .systemImage("delete.left"), color: .special),
                press_actions: [.delete(1)],
                longpress_actions: .init(repeat: [.delete(1)]),
                variations: []
            )
        )
        numberkeys[.gridFit(.init(x: 3, y: 4, width: 4, height: 1))] = .custom(
            .init(
                design: .init(label: .text("空白"), color: .normal),
                press_actions: [.input(" ")],
                longpress_actions: .init(start: [.toggleCursorBar]),
                variations: []
            )
        )
        numberkeys[.gridFit(.init(x: 7, y: 4, width: 3, height: 1))] = .system(.enter)

        let number_font = Custard(
            identifier: "number_font",
            language: .none,
            input_style: .direct,
            metadata: .init(custard_version: .v1_0, display_name: "装飾数字"),
            interface: .init(
                keyStyle: .pcStyle,
                keyLayout: .gridFit(.init(rowCount: 10, columnCount: 5)),
                keys: numberkeys
            )
        )

        do {
            try number_font.write(to: URL(fileURLWithPath: "./results/number_font.json"))
        } catch {
            print(error.localizedDescription)
        }
    }
}
