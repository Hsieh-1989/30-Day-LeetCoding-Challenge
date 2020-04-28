//: ## First Unique Number
/*:
 You have a queue of integers, you need to retrieve the first unique integer in the queue.

 Implement the `FirstUnique` class:

 - `FirstUnique(int[] nums)` Initializes the object with the numbers in the queue.
 - `int showFirstUnique()` returns the value of **the first unique** integer of the queue, and returns **-1** if there is no such integer.
 - `void add(int value)` insert value to the queue.
 
 ```
 ["FirstUnique","showFirstUnique","add","showFirstUnique","add","showFirstUnique","add","showFirstUnique"]
 [[[2,3,5]],[],[5],[],[2],[],[3],[]]
 Output:
 [null,2,null,2,null,3,null,-1]

 Explanation:
 FirstUnique firstUnique = new FirstUnique([2,3,5]);
 firstUnique.showFirstUnique(); // return 2
 firstUnique.add(5);            // the queue is now [2,3,5,5]
 firstUnique.showFirstUnique(); // return 2
 firstUnique.add(2);            // the queue is now [2,3,5,5,2]
 firstUnique.showFirstUnique(); // return 3
 firstUnique.add(3);            // the queue is now [2,3,5,5,2,3]
 firstUnique.showFirstUnique(); // return -1
 ```
 ```
 Input:
 ["FirstUnique","showFirstUnique","add","add","add","add","add","showFirstUnique"]
 [[[7,7,7,7,7,7]],[],[7],[3],[3],[7],[17],[]]
 Output:
 [null,-1,null,null,null,null,null,17]

 Explanation:
 FirstUnique firstUnique = new FirstUnique([7,7,7,7,7,7]);
 firstUnique.showFirstUnique(); // return -1
 firstUnique.add(7);            // the queue is now [7,7,7,7,7,7,7]
 firstUnique.add(3);            // the queue is now [7,7,7,7,7,7,7,3]
 firstUnique.add(3);            // the queue is now [7,7,7,7,7,7,7,3,3]
 firstUnique.add(7);            // the queue is now [7,7,7,7,7,7,7,3,3,7]
 firstUnique.add(17);           // the queue is now [7,7,7,7,7,7,7,3,3,7,17]
 firstUnique.showFirstUnique(); // return 17

 ```
 ```
 Input:
 ["FirstUnique","showFirstUnique","add","showFirstUnique"]
 [[[809]],[],[809],[]]
 Output:
 [null,809,null,-1]

 Explanation:
 FirstUnique firstUnique = new FirstUnique([809]);
 firstUnique.showFirstUnique(); // return 809
 firstUnique.add(809);          // the queue is now [809,809]
 firstUnique.showFirstUnique(); // return -1
 ```
 > Constraints:
 >
 > - `1 <= nums.length <= 10^5`
 > - `1 <= nums[i] <= 10^8`
 > - `1 <= value <= 10^8`
 > - At most `50000` calls will be made to `showFirstUnique` and `add`.
 */
class FirstUnique {
    
    final class Node {
        var value: Int
        var previous: Node?
        var next: Node?
        
        init(value: Int) {
            self.value = value
            self.previous = nil
            self.next = nil
        }
    }

    private(set) var map: [Int: Node]
    private let head: Node
    private let tail: Node

    init(_ nums: [Int]) {
        self.map = [:]
        head = Node(value: -1)
        tail = Node(value: -1)
        head.next = tail
        tail.previous = head
        nums.forEach(add(_:))
    }
    
    func showFirstUnique() -> Int {
        guard let first = head.next, first !== tail else {
            return -1
        }
        return first.value
    }
    
    func add(_ value: Int) {
        if let node = map[value] {
            remove(node: node)
        } else {
            let node = Node(value: value)
            map[value] = node
            add(node: node)
        }
    }
    
    private func add(node: Node) {
        let last = tail.previous
        tail.previous = node
        node.next = tail
        node.previous = last
        last?.next = node
    }
    
    private func remove(node: Node) {
        let previous = node.previous
        let next = node.next
        previous?.next = next
        next?.previous = previous
        node.next = nil
        node.previous = nil
    }
}

import XCTest

class TestCase: XCTestCase {
    func test_FirstUnique() {
        let queue = FirstUnique([2, 3, 5])
        XCTAssertEqual(queue.showFirstUnique(), 2)
        
        queue.add(5)
        XCTAssertEqual(queue.showFirstUnique(), 2)
        
        queue.add(2)
        XCTAssertEqual(queue.showFirstUnique(), 3)

        queue.add(3)
        XCTAssertEqual(queue.showFirstUnique(), -1)
    }
}

TestCase.defaultTestSuite.run()
