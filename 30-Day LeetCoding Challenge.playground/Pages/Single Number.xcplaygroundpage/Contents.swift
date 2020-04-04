//: [Single Number](https://leetcode.com/problems/single-number/)
/*:
Given a **non-empty** array of integers, every element appears twice except for one. Find that single one.

**Note:**

Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?
 
 ```
 Input: [2,2,1]
 Output: 1
 ```
 ```
 Input: [4,1,2,1,2]
 Output: 4
 ```
 
 */

// using set as extra memory
func singleNumber(_ nums: [Int]) -> Int {
    var temp = Set<Int>()
    for num in nums {
        if temp.contains(num) {
            temp.remove(num)
        } else {
            temp.insert(num)
        }
    }
    return temp.first!
}

// using binary operator
func singleNumber2(_ nums: [Int]) -> Int {
    nums.reduce(into: 0, ^=)
}

// test
import XCTest

class TestCase: XCTestCase {
    let input1 = [2,2,1]
    let input2 = [4,1,2,1,2]

    func test_singleNumber() {
        XCTAssertEqual(singleNumber([2,2,1]), 1)
        XCTAssertEqual(singleNumber([4,1,2,1,2]), 4)
    }
    
    func test_singleNumber_usingBinaryOperator() {
        XCTAssertEqual(singleNumber2([2,2,1]), 1)
        XCTAssertEqual(singleNumber2([4,1,2,1,2]), 4)
    }
}

TestCase.defaultTestSuite.run()
