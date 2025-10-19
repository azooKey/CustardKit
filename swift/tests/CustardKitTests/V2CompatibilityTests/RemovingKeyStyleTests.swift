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
                CustardInterface.quickDecode(target: target),
                .init(keyLayout: .gridScroll(.init(direction: .horizontal, horizontalKeyCapacity: 7.5, verticalKeyCapacity: 3.3)), keys: [:])
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
            XCTAssertEqual(
                CustardInterface.quickDecode(target: target),
                .init(keyLayout: .gridScroll(.init(direction: .horizontal, horizontalKeyCapacity: 5.5, verticalKeyCapacity: 4.4)), keys: [:])
            )
        }
    }
}
