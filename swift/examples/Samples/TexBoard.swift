import Foundation
import CustardKit

extension Samples {
    func makeTexBoard() {
        let tex_tab = Custard(
            identifier: "tex_board",
            language: .none,
            input_style: .direct,
            metadata: .init(custard_version: .v1_0, display_name: "tex"),
            interface: .init(
                keyStyle: .tenkeyStyle,
                keyLayout: .gridFit(.init(rowCount: 5, columnCount: 4)),
                keys: [
                    .gridFit(.init(x: 0, y: 0)): .custom(
                        .init(
                            design: .init(label: .text("tex"), color: .selected),
                            press_actions: [.moveTab(.system(.flick_numbersymbols))],
                            longpress_actions: .init(start: [.toggleTabBar]),
                            variations: [
                                .init(
                                    type: .flickVariation(.top),
                                    key: .init(
                                        design: .init(label: .text("☆123")),
                                        press_actions: [.moveTab(.system(.flick_numbersymbols))],
                                        longpress_actions: .none
                                    )
                                )
                            ]
                        )
                    ),
                    .gridFit(.init(x: 0, y: 1)): .system(.flickAbcTab),
                    .gridFit(.init(x: 0, y: 2)): .system(.flickHiraTab),
                    .gridFit(.init(x: 0, y: 3)): .system(.changeKeyboard),
                    .gridFit(.init(x: 1, y: 0)): .custom(.flickSimpleInputs(center: "1", subs: ["2", "3", "4", "5"], centerLabel: "12345")),
                    .gridFit(.init(x: 2, y: 0)): .custom(.flickSimpleInputs(center: "6", subs: ["7", "8", "9", "0"], centerLabel: "67890")),
                    .gridFit(.init(x: 3, y: 0)): .custom(
                        .init(
                            design: .init(label: .text("/+^-_"), color: .normal),
                            press_actions: [.input("\\frac{}{}"), .moveCursor(-3)],
                            longpress_actions: .none,
                            variations: [
                                .init(
                                    type: .flickVariation(.left),
                                    key: .init(
                                        design: .init(label: .text("+")),
                                        press_actions: [.input("+")],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.top),
                                    key: .init(
                                        design: .init(label: .text("^")),
                                        press_actions: [.input("^")],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.right),
                                    key: .init(
                                        design: .init(label: .text("-")),
                                        press_actions: [.input("-")],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.bottom),
                                    key: .init(
                                        design: .init(label: .text("_")),
                                        press_actions: [.input("_")],
                                        longpress_actions: .none
                                    )
                                )
                            ]
                        )
                    ),
                    .gridFit(.init(x: 1, y: 1)): .custom(
                        .init(
                            design: .init(label: .text("\\&/"), color: .normal),
                            press_actions: [.input("&")],
                            longpress_actions: .none,
                            variations: [
                                .init(
                                    type: .flickVariation(.left),
                                    key: .init(
                                        design: .init(label: .text("\\")),
                                        press_actions: [.input("\\")],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.top),
                                    key: .init(
                                        design: .init(label: .text("~")),
                                        press_actions: [.input("~")],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.right),
                                    key: .init(
                                        design: .init(label: .text("/")),
                                        press_actions: [.input("/")],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.bottom),
                                    key: .init(
                                        design: .init(label: .text("|")),
                                        press_actions: [.input("|")],
                                        longpress_actions: .none
                                    )
                                )
                            ]
                        )
                    ),

                        .gridFit(.init(x: 2, y: 1)): .custom(
                            .init(
                                design: .init(label: .text("•±×∓÷"), color: .normal),
                                press_actions: [.input("\\cdot ")],
                                longpress_actions: .none,
                                variations: [
                                    .init(
                                        type: .flickVariation(.left),
                                        key: .init(
                                            design: .init(label: .text("±")),
                                            press_actions: [.input("\\pm ")],
                                            longpress_actions: .none
                                        )
                                    ),
                                    .init(
                                        type: .flickVariation(.top),
                                        key: .init(
                                            design: .init(label: .text("×")),
                                            press_actions: [.input("\\times ")],
                                            longpress_actions: .none
                                        )
                                    ),
                                    .init(
                                        type: .flickVariation(.right),
                                        key: .init(
                                            design: .init(label: .text("∓")),
                                            press_actions: [.input("\\mp ")],
                                            longpress_actions: .none
                                        )
                                    ),
                                    .init(
                                        type: .flickVariation(.bottom),
                                        key: .init(
                                            design: .init(label: .text("±")),
                                            press_actions: [.input("\\div ")],
                                            longpress_actions: .none
                                        )
                                    )
                                ]
                            )
                        ),
                    .gridFit(.init(x: 3, y: 1)): .custom(
                        .init(
                            design: .init(label: .text("{}()[]"), color: .normal),
                            press_actions: [.input("{}"), .moveCursor(-1)],
                            longpress_actions: .none,
                            variations: [
                                .init(
                                    type: .flickVariation(.left),
                                    key: .init(
                                        design: .init(label: .text("〈〉")),
                                        press_actions: [.input("\\left\\langle\\right\\rangle"), .moveCursor(-13)],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.top),
                                    key: .init(
                                        design: .init(label: .text("[]")),
                                        press_actions: [.input("\\left[\\right]"), .moveCursor(-7)],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.right),
                                    key: .init(
                                        design: .init(label: .text("()")),
                                        press_actions: [.input("\\left(\\right)"), .moveCursor(-7)],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.bottom),
                                    key: .init(
                                        design: .init(label: .text("")),
                                        press_actions: [.input("\\left\\{\\right\\}"), .moveCursor(-8)],
                                        longpress_actions: .none
                                    )
                                )
                            ]
                        )
                    ),
                    .gridFit(.init(x: 1, y: 2)): .custom(
                        .init(
                            design: .init(label: .text("∫∂∬∮"), color: .normal),
                            press_actions: [.input("\\int^{}_{}"), .moveCursor(-4)],
                            longpress_actions: .none,
                            variations: [
                                .init(
                                    type: .flickVariation(.left),
                                    key: .init(
                                        design: .init(label: .text("∂")),
                                        press_actions: [.input("\\partial ")],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.top),
                                    key: .init(
                                        design: .init( label: .text("∬")),
                                        press_actions: [.input("\\iint ")],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.right),
                                    key: .init(
                                        design: .init(label: .text("∮")),
                                        press_actions: [.input("\\oint ")],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.bottom),
                                    key: .init(
                                        design: .init(label: .systemImage("shippingbox")),
                                        press_actions: [.input("\\begin{}\\end{}"), .moveCursor(-7)],
                                        longpress_actions: .none
                                    )
                                )
                            ]
                        )
                    ),
                    .gridFit(.init(x: 2, y: 2)): .custom(
                        .init(
                            design: .init(label: .text("Σ"), color: .normal),
                            press_actions: [.input("\\sum^{}_{}"), .moveCursor(-4)],
                            longpress_actions: .none,
                            variations: [
                                .init(
                                    type: .flickVariation(.left),
                                    key: .init(
                                        design: .init(label: .text("lim")),
                                        press_actions: [.input("\\lim_{}"), .moveCursor(-1)],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.top),
                                    key: .init(
                                        design: .init(label: .text("log")),
                                        press_actions: [.input("\\log_{}"), .moveCursor(-1)],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.right),
                                    key: .init(
                                        design: .init(label: .text("√")),
                                        press_actions: [.input("\\sqrt{}"), .moveCursor(-1)],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.bottom),
                                    key: .init(
                                        design: .init(label: .text("√")),
                                        press_actions: [.input("\\sqrt[]{}"), .moveCursor(-3)],
                                        longpress_actions: .none
                                    )
                                )
                            ]
                        )
                    ),
                    .gridFit(.init(x: 3, y: 2)): .custom(
                        .init(
                            design: .init(label: .text("="), color: .normal),
                            press_actions: [.input("=")],
                            longpress_actions: .none,
                            variations: [
                                .init(
                                    type: .flickVariation(.left),
                                    key: .init(
                                        design: .init(label: .text("<")),
                                        press_actions: [.input("<")],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.top),
                                    key: .init(
                                        design: .init(label: .text("≠")),
                                        press_actions: [.input("\\ne ")],
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
                                        design: .init(label: .text("≡")),
                                        press_actions: [.input("\\equiv ")],
                                        longpress_actions: .none
                                    )
                                )
                            ]
                        )
                    ),
                    .gridFit(.init(x: 1, y: 3)): .custom(
                        .init(
                            design: .init(label: .systemImage("bold.italic.underline"), color: .normal),
                            press_actions: [.input("{\\bf }"), .moveCursor(-1)],
                            longpress_actions: .none,
                            variations: [
                                .init(
                                    type: .flickVariation(.left),
                                    key: .init(
                                        design: .init(label: .text("rm")),
                                        press_actions: [.input("{\\rm }"), .moveCursor(-1)],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.top),
                                    key: .init(
                                        design: .init(label: .text("mathbb")),
                                        press_actions: [.input("\\mathbb ")],
                                        longpress_actions: .none
                                    )
                                )
                            ]
                        )
                    ),
                    .gridFit(.init(x: 2, y: 3)): .custom(
                        .init(
                            design: .init(label: .text("π∞∅"), color: .normal),
                            press_actions: [.input("\\pi ")],
                            longpress_actions: .none,
                            variations: [
                                .init(
                                    type: .flickVariation(.left),
                                    key: .init(
                                        design: .init(label: .text("∞")),
                                        press_actions: [.input("\\infty ")],
                                        longpress_actions: .none
                                    )
                                ),
                                .init(
                                    type: .flickVariation(.top),
                                    key: .init(
                                        design: .init(label: .text("∅")),
                                        press_actions: [.input("\\empty ")],
                                        longpress_actions: .none
                                    )
                                )
                            ]
                        )
                    ),
                    .gridFit(.init(x: 3, y: 3)): .custom(.flickSimpleInputs(center: ".", subs: [",", "!", "?"], centerLabel: ".,!?")),
                    .gridFit(.init(x: 4, y: 0)): .custom(.flickDelete()),
                    .gridFit(.init(x: 4, y: 1)): .custom(.flickSpace()),
                    .gridFit(.init(x: 4, y: 2, width: 1, height: 2)): .system(.enter)
                ]
            )
        )

        do {
            try tex_tab.write(to: URL(fileURLWithPath: "./results/tex.json"))
        } catch {
            print(error.localizedDescription)
        }
    }
}
