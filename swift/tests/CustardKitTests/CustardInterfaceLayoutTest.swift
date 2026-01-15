import XCTest
@testable import CustardKit

final class CustardInterfaceLayoutTest: XCTestCase {
    func testDecode() {
        do {
            let target = """
            {
                "type": "grid_fit",
                "row_count": 5,
                "column_count": 4
            }
            """
            XCTAssertEqual(CustardInterfaceLayout.quickDecode(target: target), .gridFit(.init(horizontalKeyCapacity: 5, verticalKeyCapacity: 4)))
        }
        do {
            let target = """
            {
                "type": "grid_scroll",
                "direction": "vertical",
                "row_count": 8,
                "column_count": 4.9
            }
            """
            XCTAssertEqual(CustardInterfaceLayout.quickDecode(target: target), .gridScroll(.init(direction: .vertical, horizontalKeyCapacity: 8, verticalKeyCapacity: 4.9)))
        }
        do {
            let target = """
            {
                "type": "grid_fit",
                "direction": "vertical",
                "row_count": 4.2,
                "column_count": 3.1
            }
            """
            XCTAssertEqual(CustardInterfaceLayout.quickDecode(target: target), .gridFit(.init(horizontalKeyCapacity: 4, verticalKeyCapacity: 3)))
        }
    }

    func testEncode() {
        do {
            let target = CustardInterfaceLayout.gridFit(.init(horizontalKeyCapacity: 3, verticalKeyCapacity: 5))
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
        do {
            let target = CustardInterfaceLayout.gridScroll(.init(direction: .horizontal, horizontalKeyCapacity: 3.1, verticalKeyCapacity: 2.9))
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
        do {
            let target = CustardInterfaceLayout.gridScroll(.init(direction: .vertical, horizontalKeyCapacity: 10, verticalKeyCapacity: 1))
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
    }

    static var allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode)
    ]
}
