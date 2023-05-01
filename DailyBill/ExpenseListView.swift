import SwiftUI

struct ExpenseListView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var expenses: [Expense] = []
    @State private var currentDate: Date = Date()
    @State private var showJSONAlert = false
    @State private var showJSONView = false
    
    let dataManager = DataManager()
    
    var body: some View {
        VStack {
            Text("\(currentDate, style: .date)")
                .font(.largeTitle)
                .padding(.top)
            
            List {
                ForEach(expenses) { expense in
                    HStack {
                        Text(expense.name)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .font(.system(.body, design: .monospaced))
                        
                        Spacer()
                        
                        Text("\(expense.cost, specifier: "%.2f")")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                            .font(.system(.body, design: .monospaced))
                    }
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
            }
            .onAppear {
                expenses = dataManager.loadExpenses().filter { Calendar.current.isDate($0.date, inSameDayAs: currentDate) }
            }
            
            HStack {
                Text("Итог")
                    .font(.title3)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Text("\(expenses.map { $0.cost }.reduce(0, +), specifier: "%.2f")")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        }
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading:
                                Button(action: {
            showJSONView.toggle()
        }) {
            Image(systemName: "square.and.arrow.down")
        }, trailing:
                                NavigationLink(destination: AddExpenseView()) {
            Image(systemName: "plus")
        }
        )
        .alert(isPresented: $showJSONAlert) {
            Alert(title: Text("JSON трат за \(currentDate, style: .date)"), message: Text(getJSONString()), primaryButton: .default(Text("Скопировать")) {
                UIPasteboard.general.string = getJSONString()
            }, secondaryButton: .default(Text("Показать")) {
                showJSONView = true
            })
        }
        .sheet(isPresented: $showJSONView) {
            JSONView(jsonString: getJSONString())
        }
        .gesture(DragGesture(minimumDistance: 50)
            .onEnded { value in
                if value.translation.width > 0 {
                    currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
                    expenses = dataManager.loadExpenses().filter { Calendar.current.isDate($0.date, inSameDayAs: currentDate) }
                } else if value.translation.width < 0 {
                    if !Calendar.current.isDateInToday(currentDate) {
                        currentDate = Calendar.current
                            .date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                        expenses = dataManager.loadExpenses().filter { Calendar.current.isDate($0.date, inSameDayAs: currentDate) }
                    }
                }
            }
        )
    }
    
    func getJSONString() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(expenses) {
            if let jsonString = String(data: data, encoding: .utf8) {
                return jsonString
            } else {
                return "Ошибка при конвертации данных в JSON"
            }
        } else {
            return "Ошибка при конвертации данных в JSON"
        }
    }
}
