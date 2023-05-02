import Foundation

class DataManager: ObservableObject {
    static let shared = DataManager()
    private let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("expenses").appendingPathExtension("json")
    
    @Published var expenses: [Expense] = [] {
        didSet {
            // Удалите вызов loadExpenses() здесь
        }
    }
    @Published var selectedDate: Date = Date() {
        didSet {
            // Замените вызов loadExpenses() на updateExpensesForSelectedDate()
            updateExpensesForSelectedDate()
        }
    }
    @Published var showAddExpenseScreen = false
    
    init() {
        loadExpenses()
    }
    
    func saveExpenses(_ expenses: [Expense]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(expenses) {
            do {
                try data.write(to: fileURL)
            } catch {
                print("Error saving expenses: \(error.localizedDescription)")
            }
        }
    }
    
    func loadExpenses() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL)
            let expenses = try decoder.decode([Expense].self, from: data)
            self.expenses = expenses.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
        } catch {
            print("Error loading expenses: \(error.localizedDescription)")
        }
    }
    
    // Добавьте этот новый метод
    func updateExpensesForSelectedDate() {
        let allExpenses = loadAllExpenses()
        expenses = allExpenses.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    func loadAllExpenses() -> [Expense] {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL)
            let expenses = try decoder.decode([Expense].self, from: data)
            return expenses
        } catch {
            print("Error loading all expenses: \(error.localizedDescription)")
        }
        return []
    }
    
    func saveAllExpenses(_ expenses: [Expense]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(expenses) {
            do {
                try data.write(to: fileURL)
                // Замените вызов loadExpenses() на updateExpensesForSelectedDate()
                updateExpensesForSelectedDate()
            } catch {
                print("Error saving all expenses: \(error.localizedDescription)")
            }
        }
    }
}
