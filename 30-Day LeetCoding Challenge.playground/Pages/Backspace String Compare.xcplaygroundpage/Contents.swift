//: [Backspace String Compare](https://leetcode.com/problems/backspace-string-compare/)
/*:
Given two strings **S** and **T**, return if they are equal when both are typed into empty text editors. **#** means a backspace character.

If there are two middle nodes, return the second middle node.
 ```
 Input: S = "ab#c", T = "ad#c"
 Output: true
 Explanation: Both S and T become "ac".
 ```
 ```
 Input: S = "ab##", T = "c#d#"
 Output: true
 Explanation: Both S and T become "".
 ```
 ```
 Input: S = "a##c", T = "#a#c"
 Output: true
 Explanation: Both S and T become "c".
 ```
 ```
 Input: S = "a#c", T = "b"
 Output: false
 Explanation: S becomes "c" while T becomes "b".
 ```
 **Note:**
 1. 1 <= S.length <= 200
 2. 1 <= T.length <= 200
 3. S and T only contain lowercase letters and '#' characters.
 
 **Follow up:**
 - Can you solve it in O(N) time and O(1) space?
 */

func backspaceCompare(_ S: String, _ T: String) -> Bool {
    func final(_ s: String) -> String {
        var string = s
        var index = string.startIndex
        while index < string.endIndex {
            if index == s.startIndex, string[index] == "#" {
                string.remove(at: index)
            } else if string.index(after: index) < string.endIndex, string[string.index(after: index)] == "#" {
                string.remove(at: index)
                string.remove(at: index)
                if string.startIndex != index {
                    index = string.index(before: index)
                }
            } else {
                index = string.index(after: index)
            }
        }
        return string
    }
    return final(S) == final(T)
}

// clean solution
func backspaceCompare2(_ S: String, _ T: String) -> Bool {
    func final(_ s: String) -> [Character] {
        return s.reduce(into: []) {
            if $1 == "#" {
                if !$0.isEmpty {
                    $0.removeLast()
                }
            } else {
                $0.append($1)
            }
        }
    }
    return final(S) == final(T)
}

// test
import XCTest

class TestCase: XCTestCase {
    
    func test_backspaceCompare() {
        
        XCTAssertTrue(backspaceCompare("ab#c", "ad#c"))
        XCTAssertTrue(backspaceCompare("ab##", "c#d#"))
        XCTAssertTrue(backspaceCompare("a##c", "#a#c"))
        
        XCTAssertFalse(backspaceCompare("a#c", "b"))
    }
    
    func test_backspaceCompare2() {
        
        XCTAssertTrue(backspaceCompare2("ab#c", "ad#c"))
        XCTAssertTrue(backspaceCompare2("ab##", "c#d#"))
        XCTAssertTrue(backspaceCompare2("a##c", "#a#c"))
      
        XCTAssertFalse(backspaceCompare2("a#c", "b"))
    }
}

TestCase.defaultTestSuite.run()
