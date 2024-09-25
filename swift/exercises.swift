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
        let fileData: Data = try Data(contentsOf: fileURL)
        let fileText: String? = String(data: fileData, encoding: .utf8)
        let fileLines: [String] = fileText?.components(separatedBy: NSCharacterSet.newlines) ?? []
        let trimmed: [String] = fileLines.map({$0.trimmingCharacters(in: .whitespacesAndNewlines)})
        let hasContent: [String] = trimmed.filter({!($0.isEmpty)})
        let notComment: [String] = hasContent.filter({!($0).hasPrefix("#")})
        return .success(notComment.count)
    }
    catch{
        return .failure(NoSuchFileError())
    }
}

// Write your Quaternion struct here

// Write your Binary Search Tree enum here
