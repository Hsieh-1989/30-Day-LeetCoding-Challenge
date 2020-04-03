//: [Maximum Subarray](https://leetcode.com/problems/maximum-subarray/)
/*:
 Given an integer array **nums**, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.
 
 ```
 Input: [-2,1,-3,4,-1,2,1,-5,4],
 Output: 6
 Explanation: [4,-1,2,1] has the largest sum = 6.
 ```
 
 **Follow up:**
 
 If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle
 
 */

func maxSubArray(_ nums: [Int]) -> Int {
    guard var current = nums.first else { return .min }
    var largest = current
    for i in nums.dropFirst() {
        current = max(current + i, i)
        largest = max(largest, current)
    }
    return largest
}

// Divide and conquer
func maxSubArray2(_ nums: [Int]) -> Int {
    guard nums.count > 1 else { return nums.first ?? 0 }
    let half = nums.count / 2
    let left = maxSubArray2(Array(nums[0..<half]))
    let right = maxSubArray2(Array(nums[half..<nums.count]))
    var sum = 0
    var leftSum = Int.min
    for i in (0..<half).reversed() {
        sum += nums[i]
        leftSum = max(leftSum, sum)
    }
    if leftSum == Int.min {
        leftSum = 0
    }
    sum = 0
    var rightSum = Int.min
    for i in half..<nums.count {
        sum += nums[i]
        rightSum = max(rightSum, sum)
    }
    if rightSum == Int.min {
        rightSum = 0
    }
    return max(leftSum + rightSum, left, right)
}

// test
assert(maxSubArray([-2,1,-3,4,-1,2,1,-5,4]) == 6)
assert(maxSubArray([-2,-1,-3,0]) == 0)
assert(maxSubArray([2,1]) == 3)
assert(maxSubArray([-2,-1]) == -1)
assert(maxSubArray([-1,0,-2]) == 0)
assert(maxSubArray([-2,1]) == 1)
assert(maxSubArray([1,-1,1]) == 1)
assert(maxSubArray([1, 2,-1]) == 3)
assert(maxSubArray([1, 1,-2]) == 2)
assert(maxSubArray([-1,0,-2,2]) == 2)
assert(maxSubArray([2,0,-3,2,1,0,1,-2]) == 4)
assert(maxSubArray([2,-1,-1,2,0,-3,3]) == 3)

// Divide and conquer
assert(maxSubArray2([-2,1,-3,4,-1,2,1,-5,4]) == 6)
assert(maxSubArray2([-2,-1,-3,0]) == 0)
assert(maxSubArray2([2,1]) == 3)
assert(maxSubArray2([-2,-1]) == -1)
assert(maxSubArray2([-1,0,-2]) == 0)
assert(maxSubArray2([-2,1]) == 1)
assert(maxSubArray2([1,-1,1]) == 1)
assert(maxSubArray2([1, 2,-1]) == 3)
assert(maxSubArray2([1, 1,-2]) == 2)
assert(maxSubArray2([-1,0,-2,2]) == 2)
assert(maxSubArray2([2,0,-3,2,1,0,1,-2]) == 4)
assert(maxSubArray2([2,-1,-1,2,0,-3,3]) == 3)
