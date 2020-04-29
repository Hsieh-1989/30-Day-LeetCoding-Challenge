//: [Binary Tree Maximum Path Sum ](https://leetcode.com/problems/binary-tree-maximum-path-sum/)
/*:
 Given a **non-empty** binary tree, find the maximum path sum.

 For this problem, a path is defined as any sequence of nodes from some starting node to any node in the tree along the parent-child connections. The path must contain **at least one node** and does not need to go through the root.
 ```
 Input: [1,2,3]

        1
       / \
      2   3

 Output: 6
 ```
 ```
 Input: [-10,9,20,null,null,15,7]

    -10
    / \
   9  20
     /  \
    15   7

 Output: 42
 ```
 */

func maxPathSum_brute_force_timeout(_ root: TreeNode?) -> Int {
    func maxSinglePathSum(_ node: TreeNode?) -> Int {
        guard let node = node else { return 0 }
        return max(
            node.val,
            node.val + maxSinglePathSum(node.left),
            node.val + maxSinglePathSum(node.right)
        )
    }
    guard let root = root else { return Int.min }
    
    let left = max(0, maxSinglePathSum(root.left))
    let right = max(0, maxSinglePathSum(root.right))
    let current = root.val + left + right
    return max(current, maxPathSum_brute_force_timeout(root.left), maxPathSum_brute_force_timeout(root.right))
}

func maxPathSum_optimization(_ root: TreeNode?) -> Int {
    @discardableResult
    func maxPathSum(node: TreeNode?, currentMax: inout Int) -> Int {
        guard let node = node else { return 0 }
        let left = max(maxPathSum(node: node.left, currentMax: &currentMax), 0)
        let right = max(maxPathSum(node: node.right, currentMax: &currentMax), 0)
        currentMax = max(currentMax, node.val + left + right)
        return node.val + max(left, right)
    }
    
    var result = Int.min
    maxPathSum(node: root, currentMax: &result)
    return result
}

// test
import XCTest

class TestCase: XCTestCase {
    
    func test_maxPathSum_brute_force_timeout() {
        XCTAssertEqual(maxPathSum_brute_force_timeout(TreeNode([1,2,3])), 6)
        XCTAssertEqual(maxPathSum_brute_force_timeout(TreeNode([-10,9,20,nil,nil,15,7])), 42)
    }
    
    func test_maxPathSum_optimization() {
        XCTAssertEqual(maxPathSum_optimization(TreeNode([1,2,3])), 6)
        XCTAssertEqual(maxPathSum_optimization(TreeNode([-10,9,20,nil,nil,15,7])), 42)
    }
}

TestCase.defaultTestSuite.run()
