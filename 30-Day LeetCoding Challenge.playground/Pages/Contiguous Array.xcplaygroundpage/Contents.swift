//: [Contiguous Array](https://leetcode.com/problems/contiguous-array/)
/*:
 Given a binary array, find the maximum length of a contiguous subarray with equal number of 0 and 1.
 ```
 Input: [0,1]
 Output: 2
 Explanation: [0, 1] is the longest contiguous subarray with equal number of 0 and 1.
 ```
 ```
 Input: [0,1,0]
 Output: 2
 Explanation: [0, 1] (or [1, 0]) is a longest contiguous subarray with equal number of 0 and 1.
 ```
 > The length of the given binary array will not exceed 50,000.
 */
func findMaxLength(_ nums: [Int]) -> Int {
    var result = 0
    var sum = 0
    var dict: [Int: Int] = [0: -1]
    for i in 0..<nums.count {
        sum += nums[i] == 1 ? 1 : -1
        if let previous = dict[sum] {
            result = max(result, i - previous)
        } else {
            dict[sum] = i
        }
    }
    return result
}

// test
import XCTest

class TestCase: XCTestCase {
    func testLastStoneWeight() {
        XCTAssertEqual(findMaxLength([0, 1]), 2)
        XCTAssertEqual(findMaxLength([0, 1, 0]), 2)
        XCTAssertEqual(findMaxLength([0, 1, 1]), 2)
        XCTAssertEqual(findMaxLength([0, 1, 0, 1]), 4)
        XCTAssertEqual(findMaxLength([0,1,1,1,0,1,1,1,0]), 2)
        XCTAssertEqual(findMaxLength([0,1,1,0,1,1,1,0]), 4)
        XCTAssertEqual(findMaxLength([0,0,1,0,0,0,1,1]), 6)
    }
}

TestCase.defaultTestSuite.run()
