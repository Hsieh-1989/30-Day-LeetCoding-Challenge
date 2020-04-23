//: [Bitwise AND of Numbers Range](https://leetcode.com/problems/bitwise-and-of-numbers-range/)
/*:
 Given a range [m, n] where 0 <= m <= n <= 2147483647, return the bitwise AND of all numbers in this range, inclusive.
 ```
 Input: [5,7]
 Output: 4
 ```
 ```
 Input: [0,1]
 Output: 0
 ```
 */

func rangeBitwiseAnd_loop(_ m: Int, _ n: Int) -> Int {
    var result = n
    for i in m..<n {
        result &= i
        if result == 0 {
            return 0
        }
    }
    return result
}

func rangeBitwiseAnd_recursive(_ m: Int, _ n: Int) -> Int {
    return n > m
        ? rangeBitwiseAnd_recursive(m >> 1, n >> 1) << 1
        : m
}

import XCTest

class TestCase: XCTestCase {
    func test_rangeBitwiseAnd() {
        XCTAssertEqual(rangeBitwiseAnd_loop(0, 0), 0)
        XCTAssertEqual(rangeBitwiseAnd_loop(5, 7), 4)
        XCTAssertEqual(rangeBitwiseAnd_loop(0, 1), 0)
    }
    
    func test_rangeBitwiseAnd_recursive() {
        XCTAssertEqual(rangeBitwiseAnd_recursive(0, 0), 0)
        XCTAssertEqual(rangeBitwiseAnd_recursive(5, 7), 4)
        XCTAssertEqual(rangeBitwiseAnd_recursive(0, 1), 0)
    }
}

TestCase.defaultTestSuite.run()
