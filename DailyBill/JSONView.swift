import SwiftUI

struct JSONView: View {
    var jsonString: String

    var body: some View {
        VStack {
            Text("JSON трат")
                .font(.title)
                .padding(.top, 30)

            ScrollView {
                Text(jsonString)
                    .font(.system(size: 14, design: .monospaced))
                    .padding()
            }

            Spacer()
        }
    }
}
