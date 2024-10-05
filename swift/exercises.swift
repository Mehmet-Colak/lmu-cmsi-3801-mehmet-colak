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

func firstThenLowerCase(of: [String], satisfying: (String) -> Bool) -> String? {
    let filtered: Array<String> = of.filter(satisfying)
    return (!filtered.isEmpty ? filtered[0] : nil)?.lowercased()
}

struct say {
    let phrase: String
    
    init (_ new_phrase: String = "") {
        phrase = new_phrase
    }
    
    func and(_ next_phrase: String) -> say {
        return say(phrase + " " + next_phrase)
    }
}

func meaningfulLineCount(_ filename: String) async -> Result<Int, NoSuchFileError> {
    // Swift automatically closes files once they leave the scope
    do {
        let fileURL: URL = URL(fileURLWithPath: filename)
        var lineCount: Int = 0
        let (bytes, _) = try await URLSession.shared.bytes(from: fileURL)
        for try await line in bytes.lines {
            let trimmed: String = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if !((trimmed.isEmpty) || (trimmed.hasPrefix("#"))) {
                lineCount += 1
            }
        }
        return .success(lineCount)
    } catch {
        return .failure(NoSuchFileError())
    }
}

struct Quaternion: CustomStringConvertible {
    // NMK: Looked this up, private(set) allows you to set a default value while still allowing the
    // default initializer to assign user given values to fields
    // and making it immutable to the consumer through privatizing the otherwise mutable var :NMK
    private(set) var a: Double = 0
    private(set) var b: Double = 0
    private(set) var c: Double = 0
    private(set) var d: Double = 0

    static let ZERO = Quaternion(a: 0.0, b: 0.0, c: 0.0, d: 0.0)
    static let I = Quaternion(a: 0.0, b: 1.0, c: 0.0, d: 0.0)
    static let J = Quaternion(a: 0.0, b: 0.0, c: 1.0, d: 0.0)
    static let K = Quaternion(a: 0.0, b: 0.0, c: 0.0, d: 1.0)

    static func + (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(a: lhs.a + rhs.a, b: lhs.b + rhs.b, c: lhs.c + rhs.c, d: lhs.d + rhs.d)
    }

    static func * (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        let newA = lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d
        let newB = lhs.b * rhs.a + lhs.a * rhs.b + lhs.c * rhs.d - lhs.d * rhs.c
        let newC = lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b
        let newD = lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        return Quaternion(a: newA, b: newB, c: newC, d: newD)
    }

    var coefficients: [Double] {
        return [a, b, c, d]
    }

    var conjugate: Quaternion {
        return Quaternion(a: a, b: -b, c: -c, d: -d)
    }

    static func == (lhs: Quaternion, rhs: Quaternion) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b && lhs.c == rhs.c && lhs.d == rhs.d
    }

    private func plusOrMinus(_ coeff: Double) -> String {
        if (abs(coeff) == 1.0) {
            return (coeff > 0) ? ("+") : ("-")
        }
        return coeff >= 0 ? "+" : ""
    }

    var description: String {
        let coeffs: [Double] = self.coefficients
        let dims = ["", "i", "j", "k"]
        var coeffStr = ""
        var zeroCounter = 0

        for i in 0..<coeffs.count {
            if coeffs[i] == 0 {
                zeroCounter += 1
                continue
            } else if i == 0 {
                coeffStr += "\(coeffs[i])"
            } else if abs(coeffs[i]) == 1.0 {
                coeffStr += plusOrMinus(coeffs[i]) + dims[i]
            } else {
                coeffStr += plusOrMinus(coeffs[i]) + "\(coeffs[i])" + dims[i]
            }
        }

        if zeroCounter == 4 {
            return "0"
        } else {
            if coeffStr.first == "+" {
                coeffStr.removeFirst()
            }
            return coeffStr
        }
    }
}

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
                var treeStr: String = "("
                switch left {
                    case .empty:
                        break
                    case .node:
                        treeStr += "\(left)"
                }
                treeStr += "\(value)"
                switch right {
                    case .empty:
                        break
                    case .node:
                        treeStr += "\(right)"
                }
                return treeStr + ")"
        }
    }

    func insert(_ nextVal: String) -> BinarySearchTree {
        switch self {
            case .empty:
                return .node(nextVal, BinarySearchTree.empty, BinarySearchTree.empty)
            case .node(let value, let left, let right):
                if (nextVal == value) {
                    return self
                }
                else {
                    if (nextVal < value) {
                        return .node(value, left.insert(nextVal), right)
                    }
                    else {
                        return .node(value, left, right.insert(nextVal))
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