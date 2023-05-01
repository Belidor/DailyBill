import Foundation

struct Expense: Identifiable, Codable {
    let id: UUID
    let name: String
    let cost: Double
    let date: Date
}
