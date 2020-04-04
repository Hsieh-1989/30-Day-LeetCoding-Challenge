//: [Move Zeroes](https://leetcode.com/problems/move-zeroes/)
/*:
 Given an array **nums**, write a function to move all **0**'s to the end of it while maintaining the relative order of the non-zero elements.
 
 ```
 Input: [0,1,0,3,12]
 Output: [1,3,12,0,0]
 ```
 
 **Note:**
 
 1. You must do this **in-place** without making a copy of the array.
 2. Minimize the total number of operations.
 
 */
func moveZeroes(_ nums: inout [Int]) {
    var current = 0
    var end = nums.count - 1
    while current < end {
        guard nums[current] == 0 else {
            current += 1
            continue
        }
        
        nums.swapAt(current, end)
        end -= 1
        
        for i in current..<end {
            nums.swapAt(i, i+1)
        }
    }
}

// optimize
func moveZeroes2(_ nums: inout [Int]) {
    var position = 0
    for i in nums.indices {
        guard nums[i] != 0 else { continue }
        nums.swapAt(i, position)
        position += 1
    }
}

// test
import XCTest

class TestCase: XCTestCase {
    
    func test_moveZeroes() {
        assert(
            move: moveZeroes,
            original: [0,0,1],
            expected: [1,0,0]
        )
        assert(
            move: moveZeroes,
            original: [0,1,0,3,12],
            expected: [1,3,12,0,0]
        )
        assert(
            move: moveZeroes,
            original: [0,1,0,3,12,0,1,0,3,12],
            expected: [1,3,12,1,3,12,0,0,0,0]
        )
    }
    
    func test_moveZeroes_optimize() {
        assert(
            move: moveZeroes2,
            original: [0,0,1],
            expected: [1,0,0]
        )
        assert(
            move: moveZeroes2,
            original: [0,1,0,3,12],
            expected: [1,3,12,0,0]
        )
        assert(
            move: moveZeroes2,
            original: [0,1,0,3,12,0,1,0,3,12],
            expected: [1,3,12,1,3,12,0,0,0,0]
        )
    }
    
    private func assert(
        move: (inout [Int]) -> Void,
        original: [Int],
        expected: [Int],
        line: UInt = #line
    ) {
        var copy = original
        move(&copy)
        XCTAssertEqual(copy, expected, line: line)
    }
}

TestCase.defaultTestSuite.run()
