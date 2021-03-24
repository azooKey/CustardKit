import Foundation
import CustardKit

let md_custard = Custard(
    identifier: "flick_md_ja_JP",
    language: .ja_JP,
    input_style: .direct,
    metadata: .init(custard_version: .v1_0, display_name: "markdown"),
    interface: .init(
        keyStyle: .tenkeyStyle,
        keyLayout: .gridFit(.init(rowCount: 6, columnCount: 4)),
        keys: [
            .gridFit(.init(x: 0, y: 0)): .system(.flick_star123_tab),
            .gridFit(.init(x: 0, y: 1)): .system(.flick_abc_tab),
            .gridFit(.init(x: 0, y: 2)): .custom(
                .init(
                    design: .init(label: .text("あいう"), color: .selected),
                    press_actions: [.moveTab(.custom("md_keyboard_jp"))],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 0, y: 3)): .system(.change_keyboard),
            .gridFit(.init(x: 1, y: 0)): .custom(.flick_simple_inputs(center: "あ", subs: ["い", "う", "え", "お"])),
            .gridFit(.init(x: 2, y: 0)): .custom(.flick_simple_inputs(center: "か", subs: ["き", "く", "け", "こ"])),
            .gridFit(.init(x: 3, y: 0)): .custom(.flick_simple_inputs(center: "さ", subs: ["し", "す", "せ", "そ"])),
            .gridFit(.init(x: 1, y: 1)): .custom(.flick_simple_inputs(center: "た", subs: ["ち", "つ", "て", "と"])),
            .gridFit(.init(x: 2, y: 1)): .custom(.flick_simple_inputs(center: "な", subs: ["に", "ぬ", "ね", "の"])),
            .gridFit(.init(x: 3, y: 1)): .custom(.flick_simple_inputs(center: "は", subs: ["ひ", "ふ", "へ", "ほ"])),
            .gridFit(.init(x: 1, y: 2)): .custom(.flick_simple_inputs(center: "ま", subs: ["み", "む", "め", "も"])),
            .gridFit(.init(x: 2, y: 2)): .custom(.flick_simple_inputs(center: "や", subs: ["「", "ゆ", "」", "よ"])),
            .gridFit(.init(x: 3, y: 2)): .custom(.flick_simple_inputs(center: "ら", subs: ["り", "る", "れ", "ろ"])),
            .gridFit(.init(x: 1, y: 3)): .system(.flick_kogaki),
            .gridFit(.init(x: 2, y: 3)): .custom(.flick_simple_inputs(center: "わ", subs: ["を", "ん", "ー", ""])),
            .gridFit(.init(x: 3, y: 3)): .system(.flick_kutoten),
            .gridFit(.init(x: 4, y: 0)): .custom(
                .init(
                    design: .init(label: .systemImage("bold"), color: .special),
                    press_actions: [.input("****"), .moveCursor(-2)],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .systemImage("italic")),
                                press_actions: [.input("**"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .systemImage("strikethrough")),
                                press_actions: [.input("~~~~"), .moveCursor(-2)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
                            key: .init(
                                design: .init(label: .text("√π")),
                                press_actions: [.input("$$"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.bottom),
                            key: .init(
                                design: .init(label: .text("𝚖𝚘𝚗𝚘")),
                                press_actions: [.input("``"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 1)): .custom(
                .init(
                    design: .init(label: .systemImage("link"), color: .special),
                    press_actions: [.input("[]()"), .moveCursor(-3)],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("*")),
                                press_actions: [.input("*")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .text(".")),
                                press_actions: [.input(".")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
                            key: .init(
                                design: .init(label: .text(">")),
                                press_actions: [.input(">")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.bottom),
                            key: .init(
                                design: .init(label: .text("-")),
                                press_actions: [.input("-")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 2)): .custom(
                .init(
                    design: .init(label: .text("見出し"), color: .special),
                    press_actions: [.input("# ")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("見出し2")),
                                press_actions: [.input("## ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .text("見出し3")),
                                press_actions: [.input("### ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
                            key: .init(
                                design: .init(label: .text("見出し4")),
                                press_actions: [.input("#### ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.bottom),
                            key: .init(
                                design: .init(label: .text("見出し5")),
                                press_actions: [.input("##### ")],
                                longpress_actions: .none
                            )
                        ),

                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 3)): .custom(
                .init(
                    design: .init(label: .text("```"), color: .special),
                    press_actions: [.input("```\n\n```"), .complete, .moveCursor(-4)],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .systemImage("tablecells")),
                                press_actions: [.input("""
                                        |a  |b  |c  |
                                        |---|---|---|
                                        |   |   |   |
                                        |   |   |   |
                                    """), .complete],
                                longpress_actions: .none
                            )
                        )

                    ]
                )
            ),
            .gridFit(.init(x: 5, y: 0)): .custom(.flick_delete),
            .gridFit(.init(x: 5, y: 1)): .custom(.flick_space),
            .gridFit(.init(x: 5, y: 2, width: 1, height: 2)): .system(.enter),
        ]
    )
)

do {
    try md_custard.write(to: URL(fileURLWithPath: "../results/md_keyboard.json"))
} catch {
    print(error.localizedDescription)
}
