//: [Diameter of Binary Tree](https://leetcode.com/problems/diameter-of-binary-tree/)
/*:
 Given a binary tree, you need to compute the length of the diameter of the tree. The diameter of a binary tree is the length of the **longest** path between any two nodes in a tree. This path may or may not pass through the root.
 
 Given a binary tree:
 ```
     1
    / \
   2   3
  / \
 4   5
 ```
 Return **3**, which is the length of the path [4,2,1,3] or [5,2,1,3].
 
 **Note:** The length of path between two nodes is represented by the number of edges between them.
 */


func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    return max(
        2 + (root.left.map(depth) ?? -1) + (root.right.map(depth) ?? -1),
        diameterOfBinaryTree(root.left),
        diameterOfBinaryTree(root.right)
    )
}

func depth(_ tree: TreeNode) -> Int {
    return 1 + max(tree.left.map(depth) ?? -1, tree.right.map(depth) ?? -1)
}


// test
import XCTest

class TestCase: XCTestCase {
    func test_diameterOfBinaryTree() {
        
        XCTAssertEqual(diameterOfBinaryTree(nil), 0)
        XCTAssertEqual(diameterOfBinaryTree(.init(1)), 0)
        
        //     1
        //    / \
        //   2   3
        //  / \
        // 4   5
        let node = TreeNode(1)
        node.right = TreeNode(3)
        node.left = TreeNode(2)
        node.left?.left = TreeNode(4)
        node.left?.right = TreeNode(5)
        XCTAssertEqual(diameterOfBinaryTree(node), 3)
    }
}

TestCase.defaultTestSuite.run()
