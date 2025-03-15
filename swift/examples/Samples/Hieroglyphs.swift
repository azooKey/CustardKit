import Foundation
import CustardKit

extension Samples {
    func makeHieroglyphsTab() {
        let hieroglyphs = String.UnicodeScalarView((UInt32(0x13000)...UInt32(0x133FF)).compactMap(UnicodeScalar.init)).map(String.init)

        let keys: [CustardKeyPositionSpecifier: CustardInterfaceKey] = [
            .gridScroll(0): .system(.changeKeyboard),
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
            )
        ]

        var hieroglyphs_keys = keys
        hieroglyphs.indices.forEach {
            hieroglyphs_keys[.gridScroll(GridScrollPositionSpecifier(hieroglyphs_keys.count))] = .custom(
                .init(
                    design: .init(label: .text(hieroglyphs[$0]), color: .normal),
                    press_actions: [.input(hieroglyphs[$0])],
                    longpress_actions: .none,
                    variations: []
                )
            )
        }

        let hieroglyphs_custard = Custard(
            identifier: "Hieroglyphs",
            language: .none,
            input_style: .direct,
            metadata: .init(custard_version: .v1_0, display_name: "ヒエログリフ"),
            interface: .init(
                keyStyle: .tenkeyStyle,
                keyLayout: .gridScroll(.init(direction: .vertical, rowCount: 8, columnCount: 4.2)),
                keys: hieroglyphs_keys
            )
        )

        do {
            try hieroglyphs_custard.write(to: URL(fileURLWithPath: "./results/hieroglyphs.json"))
        } catch {
            print(error.localizedDescription)
        }
    }
}
