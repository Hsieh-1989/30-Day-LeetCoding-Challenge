//: [Min Stack](https://leetcode.com/problems/min-stack/)
/*:
Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

 - push(x) -- Push element x onto stack.
 - pop() -- Removes the element on top of the stack.
 - top() -- Get the top element.
 - getMin() -- Retrieve the minimum element in the stack.
 
 ```
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin();   --> Returns -3.
 minStack.pop();
 minStack.top();      --> Returns 0.
 minStack.getMin();   --> Returns -2.
 ```
 */

final class MinStack {
    
    private(set) var array: [Int]
    private var minList: [Int]
    
    /** initialize your data structure here. */
    init(_ elements: [Int] = []) {
        self.minList = []
        self.array = []
        for element in elements {
            push(element)
        }
    }
    
    func push(_ x: Int) {
        array.append(x)
        if minList.isEmpty || minList.last! >= x {
            minList.append(x)
        }
    }
    
    func pop() {
        let last = array.removeLast()
        if last == minList.last {
            minList.removeLast()
        }
    }
    
    func top() -> Int {
        return array.last!
    }
    
    func getMin() -> Int {
        return minList.last!
    }
}

extension MinStack: ExpressibleByArrayLiteral {
    convenience init(arrayLiteral elements: Int...) {
        self.init(elements)
    }
}

extension MinStack: Equatable {
    static func == (lhs: MinStack, rhs: MinStack) -> Bool {
        return lhs.array == rhs.array
    }
}

// test
import XCTest

class TestCase: XCTestCase {
    
    func testMinStackPush() {
        let sut = MinStack()
        sut.push(1)
        sut.push(2)
        sut.push(3)
        XCTAssertEqual(sut, [1, 2, 3])
    }
    
    func testMinStackPop() {
        let sut = MinStack([1, 2, 3])
        sut.pop()
        XCTAssertEqual(sut, [1, 2])
        sut.pop()
        XCTAssertEqual(sut, [1])
        sut.pop()
        XCTAssertEqual(sut, [])
    }
    
    func testMinStackTop() {
        XCTAssertEqual(MinStack([1, 2, 3]).top(), 3)
    }
    
    func testMinStackMinValue() {
        let sut = MinStack([2, 3, 2, 1, 3, 1])
        
        XCTAssertEqual(sut, [2, 3, 2, 1, 3, 1])
        XCTAssertEqual(sut.getMin(), 1)
        
        sut.pop()
        XCTAssertEqual(sut, [2, 3, 2, 1, 3])
        XCTAssertEqual(sut.getMin(), 1)
        
        sut.pop()
        sut.pop()
        XCTAssertEqual(sut, [2, 3, 2])
        XCTAssertEqual(sut.getMin(), 2)
        
        sut.push(3)
        XCTAssertEqual(sut, [2, 3, 2, 3])
        XCTAssertEqual(sut.getMin(), 2)
        
        sut.push(0)
        XCTAssertEqual(sut, [2, 3, 2, 3, 0])
        XCTAssertEqual(sut.getMin(), 0)
        
        sut.push(1)
        XCTAssertEqual(sut, [2, 3, 2, 3, 0, 1])
        XCTAssertEqual(sut.getMin(), 0)
    }
}

TestCase.defaultTestSuite.run()
