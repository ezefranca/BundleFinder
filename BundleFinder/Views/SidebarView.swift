import SwiftUI

struct SidebarView: View {
    @ObservedObject var viewModel: AppDetailsViewModel
    @Binding var appId: String

    var body: some View {
        VStack {
            // Search Bar integrated into the sidebar header
            VStack {
                TextField("Enter App ID", text: $appId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .padding(.top)

                Button(action: {
                    viewModel.fetchAppDetails(appId: appId)
                }) {
                    Label("Search", systemImage: "magnifyingglass")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(Color(NSColor.windowBackgroundColor))

            List {
                ForEach(viewModel.history) { app in
                    HStack {
                        if let artworkUrl100 = app.artworkUrl100, let url = URL(string: artworkUrl100) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                        }

                        NavigationLink(destination: AppDetailView(appDetails: app)) {
                            Text(app.trackName ?? "Unknown App")
                                .font(.headline)
                        }
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                            viewModel.deleteApp(app)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteApp)
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Search History")

            Spacer()

            HStack {
                Button(action: {
                    if let url = viewModel.exportHistory() {
                        shareFile(url: url)
                    }
                }) {
                    Label("Export History", systemImage: "square.and.arrow.up")
                }

                Button(action: viewModel.deleteAllHistory) {
                    Label("Delete All", systemImage: "trash")
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }

    private func shareFile(url: URL) {
        let sharingPicker = NSSharingServicePicker(items: [url])
        if let window = NSApplication.shared.windows.first {
            sharingPicker.show(relativeTo: .zero, of: window.contentView!, preferredEdge: .minY)
        }
    }
}
