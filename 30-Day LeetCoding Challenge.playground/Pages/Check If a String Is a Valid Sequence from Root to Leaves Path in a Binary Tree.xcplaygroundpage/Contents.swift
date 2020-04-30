//: ## Check If a String Is a Valid Sequence from Root to Leaves Path in a Binary Tree
/*:
 Given a binary tree where each path going from the root to any leaf form a **valid sequence**, check if a given string is a **valid sequence** in such binary tree.

 We get the given string from the concatenation of an array of integers `arr` and the concatenation of all values of the nodes along a path results in a **sequence** in the given binary tree.
 
 ![Example1](leetcode_testcase_1.png)
 ```
 Input: root = [0,1,0,0,1,0,null,null,1,0,0], arr = [0,1,0,1]
 Output: true
 Explanation:
 The path 0 -> 1 -> 0 -> 1 is a valid sequence (green color in the figure).
 Other valid sequences are:
 0 -> 1 -> 1 -> 0
 0 -> 0 -> 0
 ```
 
 ![Example2](leetcode_testcase_2.png)
 ```
 Input: root = [0,1,0,0,1,0,null,null,1,0,0], arr = [0,0,1]
 Output: false
 Explanation: The path 0 -> 0 -> 1 does not exist, therefore it is not even a sequence.
 ```
 
 ![Example3](leetcode_testcase_3.png)
 ```
 Input: root = [0,1,0,0,1,0,null,null,1,0,0], arr = [0,1,1]
 Output: false
 Explanation: The path 0 -> 1 -> 1 is a sequence, but it is not a valid sequence.
 ```
 > Constraints:
 >
 > - `1 <= arr.length <= 5000`
 > - `0 <= arr[i] <= 9`
 > - Each node's value is between [0 - 9].
 */

func isValidSequence(_ root: TreeNode?, _ arr: [Int]) -> Bool {
    guard let root = root, let first = arr.first, first == root.val else { return false }
    if root.left == nil, root.right == nil, arr.count == 1 {
        return true
    } else {
        let next = Array(arr.dropFirst())
        return isValidSequence(root.left, next) || isValidSequence(root.right, next)
    }
}

// test
import XCTest

class TestCase: XCTestCase {
    func test_isValidSequence() {
        // example 1
        XCTAssertTrue(isValidSequence(TreeNode([0,1,0,0,1,0,nil,nil,1,0,0]), [0,1,0,1]))
        // example 2
        XCTAssertFalse(isValidSequence(TreeNode([0,1,0,0,1,0,nil,nil,1,0,0]), [0,0,1]))
        // example 3
        XCTAssertFalse(isValidSequence(TreeNode([0,1,0,0,1,0,nil,nil,1,0,0]), [0,1,1]))
    }
}

TestCase.defaultTestSuite.run()
