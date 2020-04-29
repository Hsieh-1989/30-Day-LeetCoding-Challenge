
// Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    public init?(_ arr: [Int?]) {
        guard !arr.isEmpty, let first = arr[0] else { return nil }
        var start = 1
        let end = arr.endIndex
        let node = TreeNode(first)
        var line: [TreeNode] = [node]
        while start < end {
            if let left = arr[start] {
                let leftNode = TreeNode(left)
                line[0].left = leftNode
                line.append(leftNode)
            }
            start += 1
            guard start < end else { break }
            if let right = arr[start] {
                let rightNode = TreeNode(right)
                line[0].right = rightNode
                line.append(rightNode)
            }
            start += 1
            line.removeFirst()
        }
        self.val = node.val
        self.left = node.left
        self.right = node.right
    }
}
