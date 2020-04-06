//: [Group Anagrams](https://leetcode.com/problems/group-anagrams/)
/*:
Given an array of strings, group anagrams together.
 ```
 Input: ["eat", "tea", "tan", "ate", "nat", "bat"],
 Output:
 [
   ["ate","eat","tea"],
   ["nat","tan"],
   ["bat"]
 ]
 ```
 **Note:**
 - All inputs will be in lowercase.
 - The order of your output does not matter.
 */
func groupAnagrams(_ strs: [String]) -> [[String]] {
    let asciiValueDefault = Character("a").asciiValue!
    func getAsciiValue(_ s: String) -> [Int] {
        var result: [Int] = [0]
        var index = 0
        for c in s {
            let value = Int(c.asciiValue! - asciiValueDefault)
            while result[index] & (1 << value) > 0 {
                index += 1
                if index == result.count {
                    result.append(0)
                }
            }
            result[index] |= (1 << value)
            index = 0
        }
        return result
    }
    var result: [[Int]: [String]] = [:]
    for str in strs {
        let value = getAsciiValue(str)
        result[value, default: []].append(str)
    }
    return result.map { $0.value }
}

// clean solution
func groupAnagrams2(_ strs: [String]) -> [[String]] {
    var result: [String: [String]] = [:]
    for s in strs {
        let sorted = String(s.sorted())
        
        var current = [String]()
        if var arr = result[sorted] {
            arr.append(s)
            current = arr
        } else {
            current = [s]
        }
        
        result[sorted] = current
    }
    
    return Array(result.values)
}

// test
import XCTest

class TestCase: XCTestCase {
    
    func test_groupAnagrams() {
        assertElementsEqual(groupAnagrams([]), [])
        assertElementsEqual(groupAnagrams(["ab", "ap"]), [["ab"], ["ap"]])
        assertElementsEqual(groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]), [["ate","eat","tea"], ["nat","tan"], ["bat"]])
    }
    
    func test_groupAnagrams_cleanSolution() {
        assertElementsEqual(groupAnagrams2([]), [])
        assertElementsEqual(groupAnagrams2(["ab", "ap"]), [["ab"], ["ap"]])
        assertElementsEqual(groupAnagrams2(["eat", "tea", "tan", "ate", "nat", "bat"]), [["ate","eat","tea"], ["nat","tan"], ["bat"]])
    }
    
    private func assertElementsEqual(_ lhs: [[String]], _ rhs: [[String]], line: UInt = #line) {
        XCTAssertEqual(
            lhs.map { $0.sorted().joined() }.sorted(),
            rhs.map { $0.sorted().joined() }.sorted(),
            line: line
        )
    }
}

TestCase.defaultTestSuite.run()
