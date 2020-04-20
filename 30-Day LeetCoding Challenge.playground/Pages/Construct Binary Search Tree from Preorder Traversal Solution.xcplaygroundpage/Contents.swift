//: [Construct Binary Search Tree from Preorder Traversal Solution](https://leetcode.com/problems/construct-binary-search-tree-from-preorder-traversal/)
/*:
 Return the root node of a binary **search** tree that matches the given `preorder` traversal.

 *(Recall that a binary search tree is a binary tree where for every node, any descendant of `node.left` has a value `<` `node.val`, and any descendant of `node.right` has a value `>` `node.val`.  Also recall that a preorder traversal displays the value of the `node` first, then traverses `node.left`, then traverses `node.right`.)*
 ```
 Input: [8,5,1,7,10,12]
 Output: [8,5,10,1,7,null,12]
 ```
 ![Example](construct-binary-search-tree-from-preorder-traversal-example.png)
 > 1. `1 <= preorder.length <= 100`
 > 2. The values of `preorder` are distinct.
 
 */

func bstFromPreorder(_ preorder: [Int]) -> TreeNode? {
    func bstFromPreorder(start: Int, end: Int) -> TreeNode? {
        guard start <= end else { return nil }
        let value = preorder[start]
        let node = TreeNode(value)
        if let index = preorder[start...end].firstIndex(where: { $0 > value }) {
            node.left = bstFromPreorder(start: start+1, end: index-1)
            node.right = bstFromPreorder(start: index, end: end)
        } else {
            node.left = bstFromPreorder(start: start+1, end: end)
        }
        return node
    }
    return bstFromPreorder(start: 0, end: preorder.endIndex-1)
}

// test
import XCTest

class TestCase: XCTestCase {
    func test_search() {
        let node = TreeNode(
            8,
            left: TreeNode(
                5,
                left: TreeNode(1),
                right: TreeNode(7)
            ),
            right: TreeNode(
                10,
                left: nil,
                right: TreeNode(12)
            )
        )
        XCTAssertEqual(bstFromPreorder([8,5,1,7,10,12]), node)
    }
}

TestCase.defaultTestSuite.run()
