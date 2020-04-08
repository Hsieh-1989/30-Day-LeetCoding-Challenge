// Definition for singly-linked list.
public class ListNode: ExpressibleByArrayLiteral {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int, next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
    
    public required init(arrayLiteral elements: Int...) {
        assert(!elements.isEmpty)
        var copy: [Int] = elements.reversed()
        self.val = copy.removeFirst()
        for i in copy {
            self.prepend(i)
        }
    }
    
    public func prepend(_ element: Int) {
        self.next = ListNode(val, next: next)
        self.val = element
    }
    
}

extension ListNode: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        guard lhs.val == rhs.val else { return false }
        var l = lhs.next
        var r = rhs.next
        while l != nil {
            guard l?.val == r?.val else { return false }
            l = l?.next
            r = r?.next
        }
        return r == nil
    }
}

extension ListNode: CustomStringConvertible {
    public var description: String {
        return "\(val) -> \(next?.description ?? "。")"
    }
}
