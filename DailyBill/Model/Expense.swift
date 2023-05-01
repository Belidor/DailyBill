import Foundation

struct Expense: Codable, Identifiable {
    let id = UUID()
    let name: String
    let cost: Double
    let date: Date
}
