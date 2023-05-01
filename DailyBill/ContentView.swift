import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6).edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Daily Bill")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 50)
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: AddExpenseView()) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color(.systemBlue))
                                    .imageScale(.large)
                                Text("Добавить трату")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                        
                        NavigationLink(destination: ExpenseListView()) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .foregroundColor(Color(.systemBlue))
                                    .imageScale(.large)
                                Text("Посмотреть траты")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}
