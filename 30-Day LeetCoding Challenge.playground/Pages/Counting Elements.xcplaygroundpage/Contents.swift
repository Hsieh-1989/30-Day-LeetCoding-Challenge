//: Counting Elements
/*:
Given an integer array **arr**, count element **x** such that **x + 1** is also in **arr**.

If there're duplicates in **arr**, count them seperately.
 ```
 Input: arr = [1,2,3]
 Output: 2
 Explanation: 1 and 2 are counted cause 2 and 3 are in arr.
 ```
 ```
 Input: arr = [1,1,3,3,5,5,7,7]
 Output: 0
 Explanation: No numbers are counted, cause there's no 2, 4, 6, or 8 in arr.
 ```
 ```
 Input: arr = [1,3,2,3,5,0]
 Output: 3
 Explanation: 0, 1 and 2 are counted cause 1, 2 and 3 are in arr.
 ```
 ```
 Input: arr = [1,1,2,2]
 Output: 2
 Explanation: Two 1s are counted cause 2 is in arr.
 ```
 **Constraints:**
 - 1 <= arr.length <= 1000
 - 0 <= arr[i] <= 1000
 */

// using set
func countElements(_ arr: [Int]) -> Int {
    var cache: Set<Int> = []
    for i in arr {
        cache.insert(i)
    }
    var total = 0
    for i in arr {
        if cache.contains(i+1) {
            total += 1
        }
    }
    return total
}

// using set (higher order function)
func countElements2(_ arr: [Int]) -> Int {
    let cache = arr.reduce(into: Set<Int>()) { $0.insert($1) }
    return arr.reduce(0) { $0 + (cache.contains($1+1) ? 1 : 0) }
}

// only loop once
func countElements3(_ arr: [Int]) -> Int {
    var result = 0
    var dict: [Int: Int] = [:]
    for i in arr {
        if dict[i+1] != nil {
            result += 1
        }
        if dict[i] == nil, let value = dict[i-1] {
            result += value
        }
        dict[i, default: 0] += 1
    }
    return result
}

// test
import XCTest

class TestCase: XCTestCase {
    
    func test_countElements() {
        XCTAssertEqual(countElements([1,2,3]), 2)
        XCTAssertEqual(countElements([1,1,3,3,5,5,7,7]), 0)
        XCTAssertEqual(countElements([1,3,2,3,5,0]), 3)
        XCTAssertEqual(countElements([1,1,2,2]), 2)
    }
    
    func test_countElements_usingHigherOrderFunction() {
        XCTAssertEqual(countElements2([1,2,3]), 2)
        XCTAssertEqual(countElements2([1,1,3,3,5,5,7,7]), 0)
        XCTAssertEqual(countElements2([1,3,2,3,5,0]), 3)
        XCTAssertEqual(countElements2([1,1,2,2]), 2)
    }
    
    func test_countElements_onePass() {
        XCTAssertEqual(countElements3([1,2,3]), 2)
        XCTAssertEqual(countElements3([1,1,3,3,5,5,7,7]), 0)
        XCTAssertEqual(countElements3([1,3,2,3,5,0]), 3)
        XCTAssertEqual(countElements3([1,1,2,2]), 2)
    }
}

TestCase.defaultTestSuite.run()

