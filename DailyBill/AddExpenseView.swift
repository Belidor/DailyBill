import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var cost = ""
    @State private var date = Date()

    let dataManager = DataManager()

    var body: some View {
        VStack {
            Text("Добавить трату")
                .font(.largeTitle)
                .padding(.top)

            Text(date, style: .date)
                .font(.headline)

            VStack {
                TextField("Наименование", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top)

                TextField("Стоимость", text: $cost)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Button(action: {
                if let costValue = Double(cost) {
                    let expense = Expense(id: UUID(), name: name, cost: costValue, date: date)
                    var expenses = dataManager.loadExpenses()
                    expenses.append(expense)
                    dataManager.saveExpenses(expenses)
                }
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Добавить")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing:
            NavigationLink(destination: ExpenseListView()) {
                Image(systemName: "list.bullet")
            }
        )

    }
}
