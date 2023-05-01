import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var dataManager = DataManager.shared
    
    @State private var name = ""
    @State private var cost = ""
    @State private var isNameEmpty = false
    @State private var isAlertShown = false
    
    var body: some View {
        VStack {
            Text("Добавить трату")
                .font(.title)
                .padding()
            
            TextField("Наименование", text: $name)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
            
            TextField("Сумма", text: $cost)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
            
            Button(action: {
                let amount = Double(cost) ?? 0.0
                let expense = Expense(name: name, cost: amount, date: Date())
                
                if expense.name.isEmpty {
                    isNameEmpty = true
                    return
                }
                
                isNameEmpty = false
                
                dataManager.saveExpenses([expense])
                
                name = ""
                cost = ""
                
                isAlertShown = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isAlertShown = false
                }
                
            }) {
                Text("Добавить")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
            }
            .background(isAlertShown ? Color.green : Color.blue)
            .cornerRadius(5)
            .padding(.top, 20)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(false)
        .alert(isPresented: $isNameEmpty) {
            Alert(title: Text("Ошибка"), message: Text("Введите наименование траты"), dismissButton: .default(Text("OK")))
        }
    }
}
