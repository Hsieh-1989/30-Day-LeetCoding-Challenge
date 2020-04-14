//: ## Perform String Shifts
/*:
 You are given a string `s` containing lowercase English letters, and a matrix `shift`, where `shift[i] = [direction, amount]`:
 - `direction` can be `0` (for left shift) or `1` (for right shift).
 - `amount` is the amount by which string `s` is to be shifted.
 - A left shift by 1 means remove the first character of `s` and append it to the end.
 - Similarly, a right shift by 1 means remove the last character of `s` and add it to the beginning.
 Return the final string after all operations.
 ```
 Input: s = "abc", shift = [[0,1],[1,2]]
 Output: "cab"
 Explanation:
 [0,1] means shift to left by 1. "abc" -> "bca"
 [1,2] means shift to right by 2. "bca" -> "cab"
 ```
 ```
 Input: s = "abcdefg", shift = [[1,1],[1,1],[0,2],[1,3]]
 Output: "efgabcd"
 Explanation:
 [1,1] means shift to right by 1. "abcdefg" -> "gabcdef"
 [1,1] means shift to right by 1. "gabcdef" -> "fgabcde"
 [0,2] means shift to left by 2. "fgabcde" -> "abcdefg"
 [1,3] means shift to right by 3. "abcdefg" -> "efgabcd"
 ```
 > Constraints:
 > - `1 <= s.length <= 100`
 > - `s` only contains lower case English letters.
 > - `1 <= shift.length <= 100`
 > - `shift[i].length == 2`
 > - `0 <= shift[i][0] <= 1`
 > - `0 <= shift[i][1] <= 100`
 */
func stringShift(_ s: String, _ shift: [[Int]]) -> String {
    let finalShift = shift.reduce(0) { $0 + $1[1] * ($1[0] == 0 ? -1 : 1) } % s.count
    let rightShift = finalShift > 0 ? finalShift : (s.count + finalShift)
    return String(s.suffix(rightShift) + s.dropLast(rightShift))
}


// test
import XCTest

class TestCase: XCTestCase {
    func testLastStoneWeight() {
        XCTAssertEqual(stringShift("abc", [[0,1],[1,2]]), "cab")
        XCTAssertEqual(stringShift("abcdefg", [[1,1],[1,1],[0,2],[1,3]]), "efgabcd")
    }
}

TestCase.defaultTestSuite.run()
