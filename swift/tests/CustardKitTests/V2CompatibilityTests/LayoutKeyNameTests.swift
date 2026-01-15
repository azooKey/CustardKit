import XCTest
import CustardKit
final class LayoutKeyNameTests: XCTestCase {
    func testDecodeV1() {
        do {
            let target = """
            {
                "type": "grid_fit",
                "row_count": 3,
                "column_count": 1
            }
            """
            XCTAssertEqual(
                CustardInterfaceLayout.quickDecode(target: target),
                .gridFit(.init(horizontalKeyCapacity: 3, verticalKeyCapacity: 1))
            )
        }
    }

    func testDecodeV2() {
        do {
            let target = """
            {
                "type": "grid_fit",
                "horizontal_key_capacity": 3,
                "vertical_key_capacity": 1
            }
            """
            XCTAssertEqual(
                CustardInterfaceLayout.quickDecode(target: target),
                .gridFit(.init(horizontalKeyCapacity: 3, verticalKeyCapacity: 1))
            )
        }
    }

    func testDecodeV1andV2() {
        do {
            let target = """
            {
                "type": "grid_fit",
                "horizontal_key_capacity": 3,
                "vertical_key_capacity": 1,
                "row_count": 2,
                "column_count": 4
            }
            """
            XCTAssertEqual(
                CustardInterfaceLayout.quickDecode(target: target),
                .gridFit(.init(horizontalKeyCapacity: 3, verticalKeyCapacity: 1))
            )
        }
    }
}
