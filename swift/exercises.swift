import Foundation

struct NegativeAmountError: Error {}
struct NoSuchFileError: Error {}

func change(_ amount: Int) -> Result<[Int:Int], NegativeAmountError> {
    if amount < 0 {
        return .failure(NegativeAmountError())
    }
    var (counts, remaining) = ([Int:Int](), amount)
    for denomination in [25, 10, 5, 1] {
        (counts[denomination], remaining) = 
            remaining.quotientAndRemainder(dividingBy: denomination)
    }
    return .success(counts)
}

// PROPERTY OF AARON
func firstThenLowerCase(of: [String], satisfying: (String) -> Bool) -> String? {
    let filtered: Array<String> = of.filter(satisfying)
    return !filtered.isEmpty ? filtered[0].lowercased() : nil
}

// PROPERTY OF AARON
struct say {
    let phrase: String
    init (_ new_phrase: String = "") {
        phrase = new_phrase
    }
    func and(_ next_phrase: String) -> say {
        return say(phrase + " " + next_phrase)
    }
}

// PROPERTY OF AARON
func meaningfulLineCount(_ filename: String) async -> Result<Int, NoSuchFileError> {
    // There is a non-zero chance I am overcomplicating this
    let fileURL: URL = URL(fileURLWithPath: filename)
    // Swift automatically closes files once they leave the scope
        
    do {
        var lineCount: Int = 0
        let (bytes, _) = try await URLSession.shared.bytes(from: fileURL)
        for try await line in bytes.lines {
            let trimmed: String = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if !((trimmed.isEmpty) || (trimmed.hasPrefix("#"))) {
                lineCount += 1
            }
        }
        return .success(lineCount)
    }
    catch{
        return .failure(NoSuchFileError())
    }
}

// Write your Quaternion struct here
//NICHOLAS MEHMET OR SEABAS

//this must be immutable
indirect struct Quaternion: CustomStringConvertible {
    let a : Double
    let b : Double
    let c : Double
    let d : Double

    static let ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
    static let I = Quaternion(0.0, 1.0, 0.0, 0.0)
    static let J = Quaternion(0.0, 0.0, 1.0, 0.0)
    static let K = Quaternion(0.0, 0.0, 0.0, 1.0)
    
    init(a: Double, b: Double, c:Double, d:Double) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.coeffs = [a, b, c, d]
    }

    //overload add
    static func + (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(a: lhs.a + rhs.a, b: lhs.b + rhs.b, c: lhs.c + rhs.c, d: lhs.d + rhs.d)
    }

    //overload multiply
    //probably wrong?
    static func * (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        let newA = lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d
        let newB = lhs.b * rhs.a + lhs.a * rhs.b + lhs.c * rhs.d - lhs.d * rhs.c
        let newC = lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b
        let newD = lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        return Quaternion(a: newA, b: newB, c: newC, d: newD)
    }

    //coefficients
    func coefficients() -> [Double] {
        return [a, b, c, d]
    }


    //conjugation
    func conjugate() -> Quaternion {
        return Quaternion(a: self.a, b: -self.b, c: -self.c, d: -self.d)
    }

    //value based equality
    static func == (lhs: Quaternion, rhs: Quaternion) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b && lhs.c == rhs.c && lhs.d == rhs.d
    }

    //str representation
    //I directly translated that, I don't know how true it is
    var description: String {
        let dims = ["", "i", "j", "k"]
        var coeffStr = ""
        var zeroCounter = 0

        for i in 0..<coeffs.count {
            if coeffs[i] == 0 {
                zeroCounter += 1
                continue
            } else if i == 0 {
                coeffStr += String(coeffs[i])
            } else if abs(coeffs[i]) == 1.0 {
                coeffStr += plusOrMinus(coeffs[i]) + dims[i]
            } else {
                coeffStr += plusOrMinus(coeffs[i]) + String(coeffs[i]) + dims[i]
            }
        }

        if zeroCounter == 4 {
            return "0"
        } else {
            if coeffStr.first == "+" {
                coeffStr.removeFirst() // Remove the leading "+"
            }
            return coeffStr
        }
    }

    private func plusOrMinus(_ value: Double) -> String {
        return value >= 0 ? "+" : "-"
    }

}

// PROPERTY OF AARON
indirect enum BinarySearchTree: CustomStringConvertible {
    case empty
    case node(String, BinarySearchTree, BinarySearchTree)
    
    var size: Int {
        switch self {
            case .empty:
                return 0
            case .node(_, let left, let right):
                return 1 + left.size + right.size
        }
    }

    var description: String {
        switch self {
            case .empty:
                return "()"
            case .node(let value, let left, let right):
                // slightly janky solution to allow for .empty's default case
                var retStr: String = "("
                switch left {
                    case .empty:
                        break
                    case .node:
                        retStr += "\(left)"
                }
                retStr += "\(value)"
                switch right {
                    case .empty:
                        break
                    case .node:
                        retStr += "\(right)"
                }
                return retStr + ")"
        }
    }

    func insert(_ next: String) -> BinarySearchTree {
        switch self {
            case .empty:
                return .node(next, BinarySearchTree.empty, BinarySearchTree.empty)
            case .node(let value, let left, let right):
                if (next == value) {
                    return self
                }
                else {
                    if (next < value) {
                        return .node(value, left.insert(next), right)
                    }
                    else {
                        return .node(value, left, right.insert(next))
                    }
                }
        }
    }

    func contains(_ lookFor: String) -> Bool {
        switch self {
            case .empty:
                return false
            case .node(let value, let left, let right):
                if (lookFor == value) {
                    return true
                }
                else {
                    return (lookFor < value) ? left.contains(lookFor) : right.contains(lookFor)
                }
        }
    }
}
