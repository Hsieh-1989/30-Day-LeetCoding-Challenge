//: [Number of Islands](https://leetcode.com/problems/number-of-islands)
/*:
 Given a 2d grid map of `'1'`s (land) and `'0'`s (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.
 ```
 Input:
 11110
 11010
 11000
 00000
 
 Output: 1
 ```
 ```
 Input:
 11000
 11000
 00100
 00011
 
 Output: 3
 ```
 */
// DFS
func numIslands(_ grid: [[Character]]) -> Int {
    func remove(_ grid: inout [[Character]], x: Int, y: Int) {
        guard x >= 0, y >= 0, y < grid.count, x < grid[y].count, grid[y][x] == "1" else { return }
        grid[y][x] = "0"
        remove(&grid, x: x+1, y: y)
        remove(&grid, x: x, y: y+1)
        remove(&grid, x: x-1, y: y)
        remove(&grid, x: x, y: y-1)
    }
    var copy = grid
    var result = 0
    for y in 0..<copy.count {
        for x in 0..<copy[y].count where copy[y][x] == "1" {
            result += 1
            remove(&copy, x: x, y: y)
        }
    }
    return result
}

// BFS
func numIslands_BFS(_ grid: [[Character]]) -> Int {
    
    func remove_BFS(_ grid: inout [[Character]], x: Int, y: Int) {
        var queue: [(x: Int, y: Int)] = [(x, y)]
        while !queue.isEmpty {
            let position = queue.removeFirst()
            guard
                position.x >= 0,
                position.y >= 0,
                position.y < grid.count,
                position.x < grid[position.y].count,
                grid[position.y][position.x] == "1"
            else { continue }
            grid[position.y][position.x] = "0"
            queue.append(contentsOf: [
                (position.x+1, position.y),
                (position.x-1, position.y),
                (position.x, position.y+1),
                (position.x, position.y-1)
            ])
        }
    }
    
    var copy = grid
    var result = 0
    for y in 0..<copy.count {
        for x in 0..<copy[y].count where copy[y][x] == "1" {
            result += 1
            remove_BFS(&copy, x: x, y: y)
        }
    }
    return result
}

// test
import XCTest

class TestCase: XCTestCase {
    func test_numIslands() {
        XCTAssertEqual(1, numIslands([["1","1","1","1","0"],
                                      ["1","1","0","1","0"],
                                      ["1","1","0","0","0"],
                                      ["0","0","0","0","0"]]))
        
        XCTAssertEqual(3, numIslands([["1","1","0","0","0"],
                                      ["1","1","0","0","0"],
                                      ["0","0","1","0","0"],
                                      ["0","0","0","1","1"]]))
        
    }
    
    func test_numIslands_BFS() {
        XCTAssertEqual(1, numIslands_BFS([["1","1","1","1","0"],
                                          ["1","1","0","1","0"],
                                          ["1","1","0","0","0"],
                                          ["0","0","0","0","0"]]))
        
        XCTAssertEqual(3, numIslands_BFS([["1","1","0","0","0"],
                                          ["1","1","0","0","0"],
                                          ["0","0","1","0","0"],
                                          ["0","0","0","1","1"]]))
    }

}

TestCase.defaultTestSuite.run()

