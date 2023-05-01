import Foundation

class DataManager {
    private let fileName = "expenses.json"
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    func saveExpenses(_ expenses: [Expense]) {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let data = try JSONEncoder().encode(expenses)
            try data.write(to: fileURL)
        } catch {
            print("Ошибка сохранения данных: \(error)")
        }
    }

    func loadExpenses() -> [Expense] {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let expenses = try JSONDecoder().decode([Expense].self, from: data)
            return expenses
        } catch {
            print("Ошибка загрузки данных: \(error)")
            return []
        }
    }
}
