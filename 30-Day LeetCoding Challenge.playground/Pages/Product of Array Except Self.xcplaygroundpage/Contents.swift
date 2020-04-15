//: [Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self/)
/*:
 Given an array `nums` of n integers where n > 1,  return an array `output` such that `output[i]` is equal to the product of all the elements of `nums` except `nums[i]`.
 ```
 Input:  [1,2,3,4]
 Output: [24,12,8,6]
 ```
 > `Constraint:` It's guaranteed that the product of the elements of any prefix or suffix of the array (including the whole array) fits in a 32 bit integer.
 >
 > Please solve it `without division` and in O(n).
 >
 > `Follow up:` Could you solve it with constant space complexity? (The output array `does not` count as extra space for the purpose of space complexity analysis.)
 */
func productExceptSelf(_ nums: [Int]) -> [Int] {
    let total =  nums.reduce(1, *)
    return nums.map { total / $0 }
}

// solution without division
func productExceptSelfWithoutDivision(_ nums: [Int]) -> [Int] {
    let count = nums.count
    var result = Array<Int>(repeating: 1, count: count)
    var l = 1
    var r = 1
    for i in 0..<count {
        result[i] *= l
        result[count - i - 1] *= r
        l *= nums[i]
        r *= nums[count - i - 1]
    }
    return result
}

// test
import XCTest

class TestCase: XCTestCase {
    func test_productExceptSelf() {
        XCTAssertEqual(productExceptSelf([1,2,3,4]), [24,12,8,6])
    }
    
    func test_productExceptSelfWithoutDivision() {
        XCTAssertEqual(productExceptSelfWithoutDivision([1,2,3,4]), [24,12,8,6])
    }
}

TestCase.defaultTestSuite.run()

