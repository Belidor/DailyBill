import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var cost: String = ""
    @State private var date: Date = Date()

    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    let dataManager = DataManager()
    let costFormatter = NumberFormatter()

    init() {
        costFormatter.numberStyle = .decimal
        costFormatter.maximumFractionDigits = 2
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Название")) {
                    TextField("Введите название", text: $name)
                }

                Section(header: Text("Стоимость")) {
                    TextField("Введите стоимость", text: $cost)
                        .keyboardType(.decimalPad)
                }

                Button(action: {
                    addExpense()
                }) {
                    Text("Добавить")
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Добавить трату", displayMode: .inline)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func addExpense() {
        if let costValue = costFormatter.number(from: cost)?.doubleValue {
            let expense = Expense(name: name, cost: costValue, date: date)
            let currentExpenses = dataManager.loadAllExpenses()
            dataManager.saveAllExpenses(currentExpenses + [expense])

            // Очистить поля ввода после сохранения
            name = ""
            cost = ""
        } else {
            // Вывод ошибки
            alertMessage = "Ошибка: неверный формат стоимости"
            showAlert = true
        }
    }
}
