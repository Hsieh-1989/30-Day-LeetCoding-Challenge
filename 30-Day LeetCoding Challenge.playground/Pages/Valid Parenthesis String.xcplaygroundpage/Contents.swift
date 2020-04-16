//: [Valid Parenthesis String](https://leetcode.com/problems/valid-parenthesis-string/)
/*:
 Given a string containing only three types of characters: '(', ')' and '*', write a function to check whether this string is valid. We define the validity of a string by these rules:
 
 1. Any left parenthesis `'('` must have a corresponding right parenthesis `')'`.
 2. Any right parenthesis `')'` must have a corresponding left parenthesis `'('`.
 3. Left parenthesis `'('` must go before the corresponding right parenthesis `')'`.
 4. `'*'` could be treated as a single right parenthesis `')'` or a single left parenthesis `'('` or an empty string.
 5. An empty string is also valid.
 
 ```
 Input: "()"
 Output: True
 ```
 ```
 Input: "(*)"
 Output: True
 ```
 ```
 Input: "(*))"
 Output: True
 ```
 > 1. The string size will be in the range [1, 100].
 */
func checkValidString(_ s: String) -> Bool {
    
    var low = 0
    var height = 0
    
    for char in s {
        switch char {
        case "(":
            low += 1
            height += 1
        case ")":
            low -= 1
            height -= 1
        default:
            low -= 1
            height += 1
        }
        low = max(0, low)
        if height < 0 {
            return false
        }
    }
    return low == 0
}

// test
import XCTest

class TestCase: XCTestCase {
    func test_productExceptSelf() {
        
        XCTAssertTrue(checkValidString("()"))
        XCTAssertTrue(checkValidString("(*)"))
        XCTAssertTrue(checkValidString("(*))"))
        XCTAssertTrue(checkValidString("(*))(*)(*)"))
        XCTAssertTrue(checkValidString("(*)"))

        XCTAssertFalse(checkValidString(")"))
        XCTAssertFalse(checkValidString("((())()()(*)(*()(())())())()()((()())((()))(*"))
        XCTAssertFalse(checkValidString("(()(()))(()()()))))((((()*()*(())())(()))((*()(*((*(*()))()(())*()()))*)*()))()()(())()(()))())))"))
    }
}

TestCase.defaultTestSuite.run()

