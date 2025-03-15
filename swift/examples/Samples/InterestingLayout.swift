import Foundation
import CustardKit

extension Samples {
    func makeInterestingLayout() {
        let interesting_layout = Custard(
            identifier: "direction",
            language: .none,
            input_style: .direct,
            metadata: .init(custard_version: .v1_0, display_name: "方向"),
            interface: .init(
                keyStyle: .tenkeyStyle,
                keyLayout: .gridFit(.init(rowCount: 5, columnCount: 4)),
                keys: [
                    .gridFit(.init(x: 0, y: 0)): .custom(
                        .init(
                            design: .init(label: .text("左上"), color: .normal),
                            press_actions: [.input("↖️")],
                            longpress_actions: .none,
                            variations: []
                        )
                    ),
                    .gridFit(.init(x: 1, y: 0, width: 3, height: 1)): .custom(
                        .init(
                            design: .init(label: .text("上"), color: .normal),
                            press_actions: [.input("⬆️")],
                            longpress_actions: .none,
                            variations: []
                        )
                    ),
                    .gridFit(.init(x: 4, y: 0)): .custom(
                        .init(
                            design: .init(label: .text("右上"), color: .normal),
                            press_actions: [.input("↗️")],
                            longpress_actions: .none,
                            variations: []
                        )
                    ),
                    .gridFit(.init(x: 0, y: 1, width: 1, height: 2)): .custom(
                        .init(
                            design: .init(label: .text("左"), color: .normal),
                            press_actions: [.input("⬅️")],
                            longpress_actions: .none,
                            variations: []
                        )
                    ),
                    .gridFit(.init(x: 1, y: 1, width: 3, height: 2)): .custom(
                        .init(
                            design: .init(label: .text("中央"), color: .normal),
                            press_actions: [.input("⏺")],
                            longpress_actions: .init(start: [.toggleTabBar]),
                            variations: []
                        )
                    ),
                    .gridFit(.init(x: 4, y: 1, width: 1, height: 2)): .custom(
                        .init(
                            design: .init(label: .text("右"), color: .normal),
                            press_actions: [.input("➡️")],
                            longpress_actions: .none,
                            variations: []
                        )
                    ),
                    .gridFit(.init(x: 0, y: 3)): .custom(
                        .init(
                            design: .init(label: .text("左下"), color: .normal),
                            press_actions: [.input("↙️")],
                            longpress_actions: .none,
                            variations: []
                        )
                    ),
                    .gridFit(.init(x: 1, y: 3, width: 3, height: 1)): .custom(
                        .init(
                            design: .init(label: .text("下"), color: .normal),
                            press_actions: [.input("⬇️")],
                            longpress_actions: .none,
                            variations: []
                        )
                    ),
                    .gridFit(.init(x: 4, y: 3)): .custom(
                        .init(
                            design: .init(label: .text("右下"), color: .normal),
                            press_actions: [.input("↘️")],
                            longpress_actions: .none,
                            variations: []
                        )
                    )
                ]
            )
        )
        do {
            try interesting_layout.write(to: URL(fileURLWithPath: "./results/direction.json"))
        } catch {
            print(error.localizedDescription)
        }
    }
}
