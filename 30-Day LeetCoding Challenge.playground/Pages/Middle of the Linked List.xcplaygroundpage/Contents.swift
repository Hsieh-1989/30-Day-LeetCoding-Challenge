//: [Middle of the Linked List](https://leetcode.com/problems/middle-of-the-linked-list/)
/*:
Given a non-empty, singly linked list with head node **head**, return a middle node of linked list.

If there are two middle nodes, return the second middle node.
 ```
 Input: [1,2,3,4,5]
 Output: Node 3 from this list (Serialization: [3,4,5])
 The returned node has value 3.  (The judge's serialization of this node is [3,4,5]).
 Note that we returned a ListNode object ans, such that:
 ans.val = 3, ans.next.val = 4, ans.next.next.val = 5, and ans.next.next.next = NULL.
 ```
 ```
 Input: [1,2,3,4,5,6]
 Output: Node 4 from this list (Serialization: [4,5,6])
 Since the list has two middle nodes with values 3 and 4, we return the second one.
 ```
 **Note:**
 - The number of nodes in the given list will be between 1 and 100.
 */

func middleNode(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head
    while fast?.next?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    return fast?.next == nil ? slow : slow?.next
}

// test
import XCTest

class TestCase: XCTestCase {
    
    func test_middleNode() {
        XCTAssertEqual(middleNode([1,2,3,4,5]), [3,4,5])
        XCTAssertEqual(middleNode([1,2,3,4,5,6]), [4,5,6])
    }
}

TestCase.defaultTestSuite.run()
