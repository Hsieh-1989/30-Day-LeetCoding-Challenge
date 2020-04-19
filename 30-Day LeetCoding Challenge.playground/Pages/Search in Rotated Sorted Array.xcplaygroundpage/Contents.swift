//: [Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array)
/*:
 Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

 (i.e., `[0,1,2,4,5,6,7]` might become `[4,5,6,7,0,1,2]`).

 You are given a target value to search. If found in the array return its index, otherwise return -1.

 You may assume no duplicate exists in the array.

 Your algorithm's runtime complexity must be in the order of O(log n).
 ```
 Input: nums = [4,5,6,7,0,1,2], target = 0
 Output: 4
 ```
 ```
 Input: nums = [4,5,6,7,0,1,2], target = 3
 Output: -1
 ```
 */

func search(_ nums: [Int], _ target: Int) -> Int {
    var start = nums.startIndex
    var end = nums.endIndex - 1
    
    while start <= end {
        let index = end - start / 2
        
        if nums[index] == target {
            return index
        } else if (nums[start] < nums[index])  {
            if nums[index] > target  {
                end = index - 1
            } else {
                start = index + 1
            }
        } else {
            if nums[index] < target, nums[index] > target {
                start = index + 1
            } else {
                end = index - 1
            }
        }
    }
    
    return -1
}

// test
import XCTest

class TestCase: XCTestCase {
    func test_search() {
        XCTAssertEqual(search([5,1,2,3,4], 1), 1)
        XCTAssertEqual(search([1,3], 3), 1)
        XCTAssertEqual(search([4,5,6,7,8,1,2,3], 8), 4)
        XCTAssertEqual(search([4,5,6,7,0,1,2], 0), 4)
        XCTAssertEqual(search([4,5,6,7,0,1,2], 3), -1)
    }
}

TestCase.defaultTestSuite.run()

