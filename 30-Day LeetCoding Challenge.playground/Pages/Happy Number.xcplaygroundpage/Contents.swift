//: [Happy Number](https://leetcode.com/problems/happy-number/)
/*:
Write an algorithm to determine if a number is "happy".

A happy number is a number defined by the following process: Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers.
 
 ```
 Input: 19
 Output: true
 Explanation:
 1^2 + 9^2 = 82
 8^2 + 2^2 = 68
 6^2 + 8^2 = 100
 1^2 + 0^2 + 02 = 1
 ```
 
 */

func isHappy(_ n: Int) -> Bool {
    var cache = Set<Int>()
    var current = n
    while true {
        current = caculate(current)
        if current == 1 {
            return true
        } else if cache.contains(current) {
            return false
        } else {
            cache.insert(current)
        }
    }
}

func caculate(_ n: Int) -> Int {
    var result = 0
    var current = n
    while current > 0 {
        result += (current % 10) * (current % 10)
        current /= 10
    }
    return result
}

// test
isHappy(19)
