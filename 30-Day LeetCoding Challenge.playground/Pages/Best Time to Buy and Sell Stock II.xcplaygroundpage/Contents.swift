//: [Best Time to Buy and Sell Stock II](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/)
/*:
 Say you have an array for which the i^th element is the price of a given stock on day i.

 Design an algorithm to find the maximum profit. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times).

 **Note:** You may not engage in multiple transactions at the same time (i.e., you must sell the stock before you buy again).
 
 ```
 Input: [7,1,5,3,6,4]
 Output: 7
 Explanation: Buy on day 2 (price = 1) and sell on day 3 (price = 5), profit = 5-1 = 4.
              Then buy on day 4 (price = 3) and sell on day 5 (price = 6), profit = 6-3 = 3.
 ```
 ```
 Input: [1,2,3,4,5]
 Output: 4
 Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
              Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are
              engaging multiple transactions at the same time. You must sell before buying again.
 ```
 ```
 Input: [7,6,4,3,1]
 Output: 0
 Explanation: In this case, no transaction is done, i.e. max profit = 0.
 ```
 */
func maxProfit(_ prices: [Int]) -> Int {
    var profit = 0
    var start = 0
    var end = prices.endIndex - 1
    var isReversed = false
    while start < end {
        if isReversed {
            if prices[start] <= prices[start + 1] {
                start += 1
            } else if prices[end] >= prices[end - 1] {
                end -= 1
            } else {
                profit += prices[start] - prices[end]
                isReversed = false
                start += 1
                end -= 1
            }
        } else {
            if prices[start] >= prices[start + 1] {
                start += 1
            } else if prices[end] <= prices[end - 1] {
                end -= 1
            } else {
                profit += prices[end] - prices[start]
                isReversed = true
                start += 1
                end -= 1
            }
        }
    }
    return profit
}

// clean solution
func maxProfit2(_ prices: [Int]) -> Int {
    guard !prices.isEmpty else { return 0 }
    var profit = 0
    for i in 1..<prices.count {
        if prices[i] > prices[i-1] {
            profit += prices[i] - prices[i-1]
        }
    }
    return profit
}


// test
import XCTest

class TestCase: XCTestCase {
    
    func test_maxProfit() {
        XCTAssertEqual(maxProfit([]), 0)
        XCTAssertEqual(maxProfit([1]), 0)
        XCTAssertEqual(maxProfit([3,3]), 0)
        XCTAssertEqual(maxProfit([3,2,6,5,0,3]), 7)
        XCTAssertEqual(maxProfit([3,2,8]), 6)
        XCTAssertEqual(maxProfit([2,3,8]), 6)
        XCTAssertEqual(maxProfit([7,1,5,3,6,4]), 7)
        XCTAssertEqual(maxProfit([7,6,8,2,3,4,3]), 4)
        XCTAssertEqual(maxProfit([1,2,3,4,5]), 4)
        XCTAssertEqual(maxProfit([7,6,4,3,1]), 0)
    }
    
    func test_maxProfit_cleanSolution() {
        XCTAssertEqual(maxProfit2([]), 0)
        XCTAssertEqual(maxProfit2([1]), 0)
        XCTAssertEqual(maxProfit2([3,3]), 0)
        XCTAssertEqual(maxProfit2([3,2,6,5,0,3]), 7)
        XCTAssertEqual(maxProfit2([3,2,8]), 6)
        XCTAssertEqual(maxProfit2([2,3,8]), 6)
        XCTAssertEqual(maxProfit2([7,1,5,3,6,4]), 7)
        XCTAssertEqual(maxProfit2([7,6,8,2,3,4,3]), 4)
        XCTAssertEqual(maxProfit2([1,2,3,4,5]), 4)
        XCTAssertEqual(maxProfit2([7,6,4,3,1]), 0)
    }
}

TestCase.defaultTestSuite.run()

