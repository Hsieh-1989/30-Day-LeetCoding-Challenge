public class BinaryMatrix: ExpressibleByArrayLiteral {
    
    private enum Binary: Int, ExpressibleByIntegerLiteral {
        case zero = 0
        case one = 1
        
        public init(integerLiteral value: Int) {
            self = value == 0 ? .zero : .one
        }
    }
    
    private let matrix: [[Binary]]
    
    public init(_ matrix: [[Int]]) {
        self.matrix = matrix.map { $0.map(Binary.init) }
    }
    
    public required convenience init(arrayLiteral elements: [Int]...) {
        self.init(elements)
    }
    
    public func get(_ x: Int, _ y: Int) -> Int {
        matrix[x][y].rawValue
    }
    
    public func dimensions() -> [Int] {
        [matrix.count, matrix.first?.count ?? 0]
    }
}
