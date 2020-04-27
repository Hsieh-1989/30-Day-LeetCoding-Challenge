//: [Maximal Square](https://leetcode.com/problems/maximal-square/)
/*:
 Given a 2D binary matrix filled with 0's and 1's, find the largest square containing only 1's and return its area.
 
 ```
 Input:

 1 0 1 0 0
 1 0 1 1 1
 1 1 1 1 1
 1 0 0 1 0

 Output: 4
 ```
 */

func maximalSquare_brute_force(_ matrix: [[Character]]) -> Int {
    
    var largest = 0
    
    func maximalSquare(x: Int, y: Int, currentLength: Int) -> Int {
        guard
            matrix[x][y] == "1",
            matrix.count > x + currentLength,
            matrix[x].count > y + currentLength
        else { return 0 }

        for i in x...x+currentLength {
            for j in y...y+currentLength {
                if matrix[i][j] == "0" {
                    return 0
                }
            }
        }
        return 1 + maximalSquare(x: x, y: y, currentLength: currentLength + 1)
    }
    
    for x in 0..<matrix.count {
        for y in 0..<matrix[x].count {
            largest = max(largest, maximalSquare(x: x, y: y, currentLength: 0))
        }
    }
    return largest * largest
}

func maximalSquare_dynamic_programing(_ matrix: [[Character]]) -> Int {
    let rows = matrix.count
    let cols = matrix.first?.count ?? 0
    var dp = Array(repeating: Array(repeating: 0, count: cols+1), count: rows+1)
    var maxLength = 0
    for i in 1...rows {
        for j in 1...cols {
            if matrix[i-1][j-1] == "1" {
                dp[i][j] = min(min(dp[i][j-1], dp[i - 1][j]), dp[i - 1][j - 1]) + 1
                maxLength = max(maxLength, dp[i][j])
            }
        }
    }
    return maxLength * maxLength
}

func maximalSquare_dynamic_programing_optimization(_ matrix: [[Character]]) -> Int {
    let rows = matrix.count
    let cols = matrix.first?.count ?? 0
    var dp = Array(repeating: 0, count: cols+1)
    var maxLength = 0
    var prev = 0
    for i in 1...rows {
        for j in 1...cols {
            let temp = dp[j];
            if matrix[i-1][j-1] == "1" {
                dp[j] = min(min(dp[j - 1], prev), dp[j]) + 1
                maxLength = max(maxLength, dp[j])
            } else {
                dp[j] = 0
            }
            prev = temp
        }
    }
    return maxLength * maxLength
}


import XCTest

class TestCase: XCTestCase {
    func test_maximalSquare_brute_force() {
        XCTAssertEqual(4, maximalSquare_brute_force([
            ["1", "0", "1", "0", "0"],
            ["1", "0", "1", "1", "1"],
            ["1", "1", "1", "1", "1"],
            ["1", "0", "0", "1", "0"],
        ]))
    }
    
    func test_maximalSquare_dynamic_programing() {
        XCTAssertEqual(4, maximalSquare_dynamic_programing([
            ["1", "0", "1", "0", "0"],
            ["1", "0", "1", "1", "1"],
            ["1", "1", "1", "1", "1"],
            ["1", "0", "0", "1", "0"],
        ]))
    }
    
    func test_maximalSquare_dynamic_programing_optimization() {
        XCTAssertEqual(4, maximalSquare_dynamic_programing_optimization([
            ["1", "0", "1", "0", "0"],
            ["1", "0", "1", "1", "1"],
            ["1", "1", "1", "1", "1"],
            ["1", "0", "0", "1", "0"],
        ]))
    }
}

TestCase.defaultTestSuite.run()
