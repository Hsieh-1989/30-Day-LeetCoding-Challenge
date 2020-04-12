//: [Last Stone Weight](https://leetcode.com/problems/last-stone-weight/)
/*:
 We have a collection of stones, each stone has a positive integer weight.

 Each turn, we choose the two heaviest stones and smash them together.  Suppose the stones have weights **x** and y with **x <= y**.  The result of this smash is:
 - If **x == y**, both stones are totally destroyed;
 - If **x != y**, the stone of weight **x** is totally destroyed, and the stone of weight **y** has new weight **y-x**.
 
 At the end, there is at most 1 stone left.  Return the weight of this stone (or 0 if there are no stones left.)
 ```
 Input: [2,7,4,1,8,1]
 Output: 1
 Explanation:
 We combine 7 and 8 to get 1 so the array converts to [2,4,1,1,1] then,
 we combine 2 and 4 to get 2 so the array converts to [2,1,1,1] then,
 we combine 2 and 1 to get 1 so the array converts to [1,1,1] then,
 we combine 1 and 1 to get 0 so the array converts to [1] then that's the value of last stone.
 ```
 > 1. 1 <= stones.length <= 30
 > 2. 1 <= stones[i] <= 1000
 */
func lastStoneWeight(_ stones: [Int]) -> Int {
    func _lastStoneWeight(_ sorted: inout [Int]) -> Int {
        guard sorted.count > 1 else { return sorted.first ?? 0 }
        let diff = sorted.removeLast() - sorted.removeLast()
        if diff != 0 {
            if let index = sorted.firstIndex(where: { $0 > diff }) {
                sorted.insert(diff, at: index)
            } else {
                sorted.append(diff)
            }
        }
        return _lastStoneWeight(&sorted)
    }
    var sorted = stones.sorted()
    return _lastStoneWeight(&sorted)
}

// test
import XCTest

class TestCase: XCTestCase {
    func testLastStoneWeight() {
        XCTAssertEqual(lastStoneWeight([2,7,4,1,8,1]), 1)
    }
}

TestCase.defaultTestSuite.run()
