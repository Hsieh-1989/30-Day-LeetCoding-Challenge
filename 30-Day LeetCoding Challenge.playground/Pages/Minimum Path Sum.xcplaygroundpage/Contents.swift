//: [Minimum Path Sum](https://leetcode.com/problems/minimum-path-sum)
/*:
 Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right which minimizes the sum of all numbers along its path.
 > You can only move either down or right at any point in time.
 ```
 Input:
 [
   [1,3,1],
   [1,5,1],
   [4,2,1]
 ]
 Output: 7
 Explanation: Because the path 1→3→1→1→1 minimizes the sum.
 ```
 */

func minPathSum(_ grid: [[Int]]) -> Int {
    
    var cache: [Int: [Int: Int]] = [:]
    let width = grid.first?.count ?? 0
    let height = grid.count
    
    func minPathSum(x: Int, y: Int) -> Int? {
        
        guard x < width, y < height else { return nil }
        
        if let value = cache[x]?[y] {
            return value
        }

        var extra: Int?
        if y != height - 1 {
            extra = minPathSum(x: x, y: y + 1)
        }
        if x != width - 1, let rightPath = minPathSum(x: x + 1, y: y) {
            extra = min(rightPath, extra ?? .max)
        }
        
        let result = grid[y][x] + (extra ?? 0)
        cache[x, default: [:]][y] = result
        return result
    }
    
    return minPathSum(x: 0, y: 0) ?? 0
}

func minPathSum2(_ grid: [[Int]]) -> Int {
    
    let row = grid.count
    let col = grid[0].count
    
    var res = grid
    
    for i in 0..<row {
        for j in 0..<col {
            
            if i == 0 && j == 0 {
                continue
            }
            
            if i-1 >= 0 && j-1 >= 0 {
                res[i][j] += min(res[i-1][j], res[i][j-1])
            } else if i - 1 < 0 {
                res[i][j] += res[i][j-1]
            } else {
                res[i][j] += res[i-1][j]
            }
        }
    }
    
    return res[row-1][col-1]
    
}


// test
import XCTest

class TestCase: XCTestCase {
    func test_minPathSum() {
        XCTAssertEqual(7, minPathSum([[1,3,1],
                                      [1,5,1],
                                      [4,2,1]]))
    }
    
    func test_minPathSum2() {
        XCTAssertEqual(7, minPathSum2([[1,3,1],
                                       [1,5,1],
                                       [4,2,1]]))
    }
}

TestCase.defaultTestSuite.run()

