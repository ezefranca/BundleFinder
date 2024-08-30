import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AppDetailsViewModel()

    @State private var appId: String = ""

    var body: some View {
        NavigationSplitView {
            SidebarView(viewModel: viewModel, appId: $appId)
        } detail: {
            if let selectedApp = viewModel.selectedApp {
                AppDetailView(appDetails: selectedApp)
            } else {
                PlaceholderView()
            }
        }
        .navigationSplitViewStyle(.balanced)
        .toast(isPresented: $viewModel.showToast, message: viewModel.toastMessage)
    }
}


#Preview {
    ContentView()
}
