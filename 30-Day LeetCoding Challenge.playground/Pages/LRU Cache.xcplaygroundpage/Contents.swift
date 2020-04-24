//: [LRU Cache](https://leetcode.com/problems/lru-cache/)
/*:
 Design and implement a data structure for [Least Recently Used (LRU) cache](https://en.wikipedia.org/wiki/Cache_replacement_policies#LRU/). It should support the following operations: `get` and `put`.
 
 `get(key)` - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
 
 `put(key, value)` - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.
 
 The cache is initialized with a **positive** capacity.
 
 **Follow up:**
 
 Could you do both operations in **O(1)** time complexity?
 
```
LRUCache cache = new LRUCache( 2 -> capacity );
 
cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // returns 1
cache.put(3, 3);    // evicts key 2
cache.get(2);       // returns -1 (not found)
cache.put(4, 4);    // evicts key 1
cache.get(1);       // returns -1 (not found)
cache.get(3);       // returns 3
cache.get(4);       // returns 4
```
*/

class LRUCache {
    
    final class Node {
        var key: Int
        var value: Int
        var previous: Node?
        var next: Node?
        
        init(key: Int, value: Int) {
            self.key = key
            self.value = value
            self.previous = nil
            self.next = nil
        }
    }
    
    let capacity: Int
    private(set) var cache: [Int: Node]
    private let head: Node
    private let tail: Node
    
    init(_ capacity: Int) {
        self.capacity = capacity
        self.cache = .init(minimumCapacity: capacity)
        head = Node(key: -1, value: -1)
        tail = Node(key: -1, value: -1)
        head.next = tail
        tail.previous = head
    }
    
    func get(_ key: Int) -> Int {
        var result = -1
        if let node = cache[key] {
            result = node.value
            remove(node: node)
            add(node: node)
        }
        return result
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            node.value = value
            remove(node: node)
        } else if cache.count == capacity, let last = tail.previous {
            cache.removeValue(forKey: last.key)
            remove(node: last)
        }
        let newNode = Node(key: key, value: value)
        cache[key] = newNode
        add(node: newNode)
    }
    
    func add(node: Node) {
        let next = head.next
        head.next = node
        node.previous = head
        node.next = next
        next?.previous = node
    }
    
    func remove(node: Node) {
        let previous = node.previous
        let next = node.next
        previous?.next = next
        next?.previous = previous
    }
}

import XCTest

class TestCase: XCTestCase {
    func test_LRUCache() {
        
        let cache = LRUCache(2)
        XCTAssertEqual(cache.get(0), -1)
        
        cache.put(1, 1)
        cache.put(2, 2)
        
        XCTAssertEqual(cache.get(1), 1)
        XCTAssertEqual(cache.cache.count, 2)

        // evicts key 2
        cache.put(3, 3);
        XCTAssertEqual(cache.cache.count, 2)
        XCTAssertEqual(cache.get(2), -1)

        // evicts key 1
        cache.put(4, 4);
        XCTAssertEqual(cache.cache.count, 2)
        XCTAssertEqual(cache.get(1), -1)

        XCTAssertEqual(cache.get(3), 3)
        XCTAssertEqual(cache.get(4), 4)
    }
}

TestCase.defaultTestSuite.run()
