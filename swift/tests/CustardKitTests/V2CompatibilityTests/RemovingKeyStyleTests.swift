import XCTest
import CustardKit
final class RemovingKeyStyleTests: XCTestCase {
    func testDecodeV1() {
        do {
            let target = """
            {
                "key_layout": {
                    "type": "grid_scroll",
                    "direction": "horizontal",
                    "horizontal_key_capacity": 7.5,
                    "vertical_key_capacity": 3.3,
                },
                "key_style": "pc_style",
                "keys": []
            }
            """
            XCTAssertEqual(
                try? CustardInterface.quickDecode(target: target).legacyKeyStyle,
                .pcStyle
            )
        }
    }

    func testDecodeV1WithKeyStyleDependentSystemKey() {
        do {
            let target = """
            {
                "key_layout": {
                    "type": "grid_scroll",
                    "direction": "horizontal",
                    "horizontal_key_capacity": 7.5,
                    "vertical_key_capacity": 3.3,
                },
                "key_style": "pc_style",
                "keys": [
                    {
                        "specifier_type": "grid_fit",
                        "specifier": {
                            "x": 1,
                            "y": 0,
                            "width": 1,
                            "height": 1
                        },
                        "key_type": "system",
                        "key": {
                            "type": "upper_lower",
                        }
                    }
                ]
            }
            """
            XCTAssertEqual(
                try? CustardInterface.quickDecode(target: target).legacyKeyStyle,
                .pcStyle
            )
            XCTAssertEqual(
                try? CustardInterface.quickDecode(target: target).keys.first!.value,
                .system(.pcStyleUpperLower)
            )
        }
    }

    func testDecodeV2() {
        do {
            let target = """
            {
                "key_layout": {
                    "type": "grid_scroll",
                    "direction": "horizontal",
                    "horizontal_key_capacity": 5.5,
                    "vertical_key_capacity": 4.4,
                },
                "keys": []
            }
            """
            XCTAssertNil(try? CustardInterface.quickDecode(target: target).legacyKeyStyle)
        }
    }
}
