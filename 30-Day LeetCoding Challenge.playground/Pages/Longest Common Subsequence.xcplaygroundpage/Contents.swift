//: [Longest Common Subsequence](https://leetcode.com/problems/longest-common-subsequence/)
/*:
 Given two strings `text1` and `text2`, return the length of their longest common subsequence.

 A subsequence of a string is a new string generated from the original string with some characters(can be none) deleted without changing the relative order of the remaining characters. (eg, "ace" is a subsequence of "abcde" while "aec" is not). A common subsequence of two strings is a subsequence that is common to both strings.

  

 If there is no common subsequence, return 0.
 ```
 Input: text1 = "abcde", text2 = "ace"
 Output: 3
 Explanation: The longest common subsequence is "ace" and its length is 3.
 ```
 ```
 Input: text1 = "abc", text2 = "abc"
 Output: 3
 Explanation: The longest common subsequence is "abc" and its length is 3.
 ```
 ```
 Input: text1 = "abc", text2 = "def"
 Output: 0
 Explanation: There is no such common subsequence, so the result is 0.
 ```
 > Constraints:
 > - `1 <= text1.length <= 1000`
 > - `1 <= text2.length <= 1000`.
 > - The input strings consist of lowercase English characters only.
 */

func longestCommonSubsequence_recursive_timeout(_ text1: String, _ text2: String) -> Int {
    func longestCommonSubsequence(_ chars1: [Character], _ chars2: [Character]) -> Int {
        guard let c1 = chars1.last, let c2 = chars2.last else { return 0 }
        return c1 == c2
            ? 1 + longestCommonSubsequence(chars1.dropLast(), chars2.dropLast())
            : max(longestCommonSubsequence(chars1.dropLast(), chars2), longestCommonSubsequence(chars1, chars2.dropLast()))
    }
    return longestCommonSubsequence(text1.map { $0 }, text2.map { $0 })
}

func longestCommonSubsequence_recursive_cache(_ text1: String, _ text2: String) -> Int {
    var cache = Array(repeating: Array(repeating: -1, count: text2.count), count: text1.count)
    func longestCommonSubsequence(_ chars1: [Character], _ chars2: [Character]) -> Int {
        guard let c1 = chars1.last, let c2 = chars2.last else { return 0 }
        if cache[chars1.count-1][chars2.count-1] != -1 {
            return cache[chars1.count-1][chars2.count-1]
        }
        cache[chars1.count-1][chars2.count-1] = c1 == c2
            ? 1 + longestCommonSubsequence(chars1.dropLast(), chars2.dropLast())
            : max(longestCommonSubsequence(chars1.dropLast(), chars2), longestCommonSubsequence(chars1, chars2.dropLast()))
        return cache[chars1.count-1][chars2.count-1]
    }
    return longestCommonSubsequence(text1.map { $0 }, text2.map { $0 })
}

func longestCommonSubsequence_optimization(_ text1: String, _ text2: String) -> Int {
    let chars1 = text1.map { $0 }
    let chars2 = text2.map { $0 }
    let n = text1.count
    let m = text2.count
    var dp = Array(repeating: Array(repeating: 0, count: m+1), count: n+1)
    for i in 1...n {
        for j in 1...m {
            dp[i][j] = chars1[i-1] == chars2[j-1]
                ? dp[i-1][j-1] + 1
                : max(dp[i-1][j], dp[i][j-1])
        }
    }
    return dp[n][m]
}




import XCTest

class TestCase: XCTestCase {
    func test_longestCommonSubsequence_recursive_timeout() {
        XCTAssertEqual(longestCommonSubsequence_recursive_timeout("abcde", "ace"), 3)
        XCTAssertEqual(longestCommonSubsequence_recursive_timeout("abc", "abc"), 3)
        XCTAssertEqual(longestCommonSubsequence_recursive_timeout("abc", "def"), 0)
        XCTAssertEqual(longestCommonSubsequence_recursive_timeout("bl", "yby"), 1)
    }

    func test_longestCommonSubsequence_recursive_cache() {
        XCTAssertEqual(longestCommonSubsequence_recursive_cache("abcde", "ace"), 3)
        XCTAssertEqual(longestCommonSubsequence_recursive_cache("abc", "abc"), 3)
        XCTAssertEqual(longestCommonSubsequence_recursive_cache("abc", "def"), 0)
        XCTAssertEqual(longestCommonSubsequence_recursive_cache("bl", "yby"), 1)
        XCTAssertEqual(longestCommonSubsequence_recursive_cache("oxcpqrsvwf", "shmtulqrypy"), 2)
    }

    func test_longestCommonSubsequence_optimization() {
        XCTAssertEqual(longestCommonSubsequence_optimization("abcde", "ace"), 3)
        XCTAssertEqual(longestCommonSubsequence_optimization("abc", "abc"), 3)
        XCTAssertEqual(longestCommonSubsequence_optimization("abc", "def"), 0)
        XCTAssertEqual(longestCommonSubsequence_optimization("bl", "yby"), 1)
        XCTAssertEqual(longestCommonSubsequence_optimization("oxcpqrsvwf", "shmtulqrypy"), 2)
    }
}

TestCase.defaultTestSuite.run()
