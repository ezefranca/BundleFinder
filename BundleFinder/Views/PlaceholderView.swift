import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        VStack {
            Spacer()
            Label("Select or Search for an App", systemImage: "applelogo")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

#Preview {
    PlaceholderView()
}
