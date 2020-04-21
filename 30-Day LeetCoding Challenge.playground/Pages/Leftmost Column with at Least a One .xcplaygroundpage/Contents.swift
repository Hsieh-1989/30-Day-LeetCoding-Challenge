//: ## Leftmost Column with at Least a One
/*:
 *(This problem is an **interactive problem**.)*

 A binary matrix means that all elements are `0` or `1`. For each **individual** row of the matrix, this row is sorted in non-decreasing order.

 Given a row-sorted binary matrix binaryMatrix, return leftmost column index(0-indexed) with at least a `1` in it. If such index doesn't exist, return `-1`.

 **You can't access the Binary Matrix directly**.  You may only access the matrix using a BinaryMatrix interface:

 - BinaryMatrix.get(x, y) returns the element of the matrix at index (x, y) (0-indexed).
 - BinaryMatrix.dimensions() returns a list of 2 elements [n, m], which means the matrix is n * m.
 
 Submissions making more than 1000 calls to BinaryMatrix.get will be judged Wrong Answer.  Also, any solutions that attempt to circumvent the judge will result in disqualification.

 For custom testing purposes you're given the binary matrix mat as input in the following four examples. You will not have access the binary matrix directly.
 
 ```
 Input: mat = [[0,0],[1,1]]
 Output: 0
 ```
 ```
 Input: mat = [[0,0],[0,1]]
 Output: 1
 ```
 ```
 Input: mat = [[0,0],[0,0]]
 Output: -1
 ```
 ```
 Input: mat = [[0,0,0,1],[0,0,1,1],[0,1,1,1]]
 Output: 1
 ```
 
 > Constraints:
 > - `1 <= mat.length, mat[i].length <= 100`
 > - `mat[i][j]` is either `0` or `1`.
 > - `mat[i]` is sorted in a non-decreasing way.
 
 > Hint
 > 1. (Binary Search) For each row do a binary search to find the leftmost one on that row and update the answer.
 > 2. (Optimal Approach) Imagine there is a pointer p(x, y) starting from top right corner. p can only move left or down. If the value at p is 0, move down. If the value at p is 1, move left. Try to figure out the correctness and time complexity of this algorithm.
 
 */
func leftMostColumnWithOne_binarySearch(_ binaryMatrix: BinaryMatrix) -> Int {
    func binarySearch(x: Int, length: Int) -> Int? {
        var result: Int? = nil
        var start = 0
        var end = length
        while start <= end {
            let half = (end - start) / 2 + start
            if binaryMatrix.get(x, half) == 1 {
                result = half
                end = half - 1
            } else {
                start = half + 1
            }
        }
        return result
    }
    let dimensions = binaryMatrix.dimensions()
    var result: Int? = nil
    for x in 0..<dimensions[0] {
        if let newResult = binarySearch(x: x, length: dimensions[1] - 1) {
            result = result == nil ? newResult : min(newResult, result!)
        }
    }
    return result ?? -1
}

func leftMostColumnWithOne_optimal(_ binaryMatrix: BinaryMatrix) -> Int {
    let dimensions = binaryMatrix.dimensions()
    var x = 0
    var y = dimensions[1] - 1
    var result = -1
    while x < dimensions[0], y >= 0 {
        while y >= 0, binaryMatrix.get(x, y) == 1 {
            result = y
            y -= 1
        }
        x += 1
    }
    return result
}


// test
import XCTest

class TestCase: XCTestCase {
    func test_leftMostColumnWithOne_binarySearch() {
        XCTAssertEqual(leftMostColumnWithOne_binarySearch([[0,0],[1,1]]), 0)
        XCTAssertEqual(leftMostColumnWithOne_binarySearch([[0,0],[0,1]]), 1)
        XCTAssertEqual(leftMostColumnWithOne_binarySearch([[0,0],[0,0]]), -1)
        XCTAssertEqual(leftMostColumnWithOne_binarySearch([[0,0,0,1],[0,0,1,1],[0,1,1,1]]), 1)
    }
    
    func test_leftMostColumnWithOne_optimal() {
        XCTAssertEqual(leftMostColumnWithOne_optimal([[0,0],[1,1]]), 0)
        XCTAssertEqual(leftMostColumnWithOne_optimal([[0,0],[0,1]]), 1)
        XCTAssertEqual(leftMostColumnWithOne_optimal([[0,0],[0,0]]), -1)
        XCTAssertEqual(leftMostColumnWithOne_optimal([[0,0,0,1],[0,0,1,1],[0,1,1,1]]), 1)
    }
}

TestCase.defaultTestSuite.run()
