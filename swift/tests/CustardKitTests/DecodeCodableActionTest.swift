import XCTest
@testable import CustardKit

final class DecodeCodableActionTest: XCTestCase {
    func testDecodeInput() {
        do{
            let target = """
            {
                "type": "input",
                "text": "😆"
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .input("😆"))
        }
        do{
            let target = """
            {
                "type": "input",
                "text": 42
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, nil)
        }
    }

    func testDecodeReplaceLastCharacters() {
        do{
            let target = """
            {
                "type": "replace_last_characters",
                "table": {
                    "天": "地",
                    "海": "山",
                    "正": "負",
                    "嬉": "悲"
                }
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .replaceLastCharacters([
                "天": "地",
                "海": "山",
                "正": "負",
                "嬉": "悲"
            ]))
        }
        do{
            let target = """
            {
                "type": "replace_last_characters",
                "table": {}
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .replaceLastCharacters([:]))
        }
    }

    func testDecodeDelete() {
        do{
            let target = """
            {
                "type": "delete",
                "count": 3
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .delete(3))
        }
        do{
            let target = """
            {
                "type": "delete",
                "count": "-8"
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, nil)
        }
    }

    func testDecodeSmartDelete() {
        do{
            let target = """
            {
                "type": "smart_delete",
                "targets": ["_"],
                "direction": "backward"
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .smartDelete(.init(targets: ["_"], direction: .backward)))
        }
        do{
            let target = """
            {
                "direction": "forward",
                "type": "smart_delete",
                "targets": ["、","。","！","？",".",",","．","，", "\\n"]
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .smartDelete())
        }
    }

    func testDecodeMoveCursor() {
        do{
            let target = """
            {
                "type": "move_cursor",
                "count": 3
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .moveCursor(3))
        }
        do{
            let target = """
            {
                "type": "move_cursor",
                "count": "-8"
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, nil)
        }
    }


    func testDecodeSmartMoveCursor() {
        do{
            let target = """
            {
                "type": "smart_move_cursor",
                "targets": ["…"],
                "direction": "backward"
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .smartMoveCursor(.init(targets: ["…"], direction: .backward)))
        }
        do{
            let target = """
            {
                "direction": "forward",
                "type": "smart_move_cursor",
                "targets": ["、","。","！","？",".",",","．","，", "\\n"]
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .smartMoveCursor())
        }
    }

    func testDecodeMoveTab() {
        do{
            let target = """
            {
                "type": "move_tab",
                "tab_type": "system",
                "identifier": "last_tab"
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .moveTab(.system(.last_tab)))
        }
        do{
            let target = """
            {
                "type": "move_tab",
                "tab_type": "custom",
                "identifier": "flick_greek"
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .moveTab(.custom("flick_greek")))
        }
    }

    func testDecodeSetActions() {
        do{
            let target = """
            {
                "type": "set_cursor_bar",
                "operation": "on",
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .setCursorBar(.on))
        }
        do{
            let target = """
            {
                "type": "set_tab_bar",
                "operation": "off",
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .setTabBar(.off))
        }
        do{
            let target = """
            {
                "type": "set_caps_lock_state",
                "operation": "toggle",
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .setCapsLockState(.toggle))
        }
        do {
            let target = """
            {
                "type": "set_bool_state",
                "state_name": "state_x",
                "bool_expression": "true",
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .setBoolState(state: "state_x", value: "true"))
        }
    }

    func testDecodeBoolSwitchAction() {
        do{
            let target = """
            {
                "type": "bool_switch",
                "bool_expression": "not(is_pressed)",
                "true_actions": [
                    {
                        "type": "set_bool_state",
                        "state_name": "is_pressed",
                        "bool_expression": "true",
                    }
                ],
                "false_actions": [
                    {
                        "type": "move_tab",
                        "tab_type": "custom",
                        "identifier": "flick_greek"
                    },
                    {
                        "type": "bool_switch",
                        "bool_expression": "not(is_pressed2)",
                        "true_actions": [
                            {
                                "type": "input",
                                "text": "hi",
                            }
                        ],
                        "false_actions": []
                    }
                ]
            }
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .boolSwitch(
                condition: "not(is_pressed)",
                trueActions: [.setBoolState(state: "is_pressed", value: "true")],
                falseActions: [
                    .moveTab(CustardKit.TabData.custom("flick_greek")),
                    .boolSwitch(
                        condition: "not(is_pressed2)",
                        trueActions: [.input("hi")],
                        falseActions: []
                    )
                ]
            ))
        }
    }

    func testDecodeNoArgumentActions() {
        do{
            let target = """
            {"type": "replace_default"}
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .replaceDefault)
        }
        do{
            let target = """
            {"type": "smart_delete_default"}
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .smartDeleteDefault)
        }
        do{
            let target = """
            {"type": "complete"}
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .complete)
        }
        do{
            let target = """
            {"type": "enable_resizing_mode"}
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .enableResizingMode)
        }
        do{
            let target = """
            {"type": "dismiss_keyboard"}
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .dismissKeyboard)
        }
    }

    func decodeDeprecatedActions() {
        do{
            let target = """
            {"type": "toggle_cursor_bar"}
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .setCursorBar(.toggle))
        }
        do{
            let target = """
            {"type": "toggle_tab_bar"}
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .setTabBar(.toggle))
        }
        do{
            let target = """
            {"type": "toggle_caps_lock_state"}
            """
            let decoded = CodableActionData.quickDecode(target: target)
            XCTAssertEqual(decoded, .setCapsLockState(.toggle))
        }
    }

    static var allTests = [
        ("testDecodeInput", testDecodeInput),
        ("testDecodeDelete", testDecodeDelete),
        ("testDecodeReplaceLastCharacters", testDecodeReplaceLastCharacters),
        ("testDecodeSmartDelete", testDecodeSmartDelete),
        ("testDecodeMoveCursor", testDecodeMoveCursor),
        ("testDecodeSmartMoveCursor", testDecodeSmartMoveCursor),
        ("testDecodeMoveTab", testDecodeMoveTab),
        ("testDecodeNoArgumentActions", testDecodeNoArgumentActions)
    ]
}
