import Foundation

struct Expense: Codable, Identifiable {
    let id = UUID()
    let name: String
    let cost: Double
    let date: Date
}
extension Expense: Equatable {
    static func == (lhs: Expense, rhs: Expense) -> Bool {
        lhs.id == rhs.id
    }
}
