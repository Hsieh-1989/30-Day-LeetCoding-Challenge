//: [Subarray Sum Equals K](https://leetcode.com/problems/subarray-sum-equals-k/)
/*:
 Given an array of integers and an integer **k**, you need to find the total number of continuous subarrays whose sum equals to **k**.
 ```
 Input:nums = [1,1,1], k = 2
 Output: 2
 ```
 > 1. The length of the array is in range [1, 20,000].
 > 2. The range of numbers in the array is [-1000, 1000] and the range of the integer **k** is [-1e7, 1e7].
 
 */

func subarraySum_bruteForce(_ nums: [Int], _ k: Int) -> Int {
    var result = 0
    for n in 0..<nums.count {
        var total = 0
        for current in n..<nums.count {
            total += nums[current]
            if total == k {
                result += 1
            }
        }
    }
    return result
}

func subarraySum_cache(_ nums: [Int], _ k: Int) -> Int {
    var cache: [Int: Int] = [0: 1]
    var result = 0
    var current = 0
    for i in 0..<nums.count {
        current += nums[i]
        if let value = cache[current - k] {
            result += value
        }
        cache[current, default: 0] += 1
    }
    return result
}

// test
import XCTest

class TestCase: XCTestCase {
    
    func test_subarraySum_bruteForce() {
        XCTAssertEqual(subarraySum_bruteForce([1,1,1], 2), 2)
        XCTAssertEqual(subarraySum_bruteForce([0,0,0,0,0,0,0,0,0,0], 0), 55)
    }
    
    func test_subarraySum_cache() {
        XCTAssertEqual(subarraySum_cache([1,1,1], 2), 2)
        XCTAssertEqual(subarraySum_cache([0,0,0,0,0,0,0,0,0,0], 0), 55)
    }
}

TestCase.defaultTestSuite.run()
