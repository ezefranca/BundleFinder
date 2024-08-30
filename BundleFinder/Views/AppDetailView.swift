import SwiftUI

struct AppDetailView: View {
    let appDetails: AppDetails
    @State private var isDescriptionCollapsed: Bool = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let artworkUrl100 = appDetails.artworkUrl100, let url = URL(string: artworkUrl100) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(12)
                }

                // App ID with tap-to-copy functionality
                Text("App ID: \(appDetails.searchedAppId)")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        copyToClipboard(appDetails.searchedAppId)
                    }
                    .contextMenu {
                        Button {
                            copyToClipboard(appDetails.searchedAppId)
                        } label: {
                            Label("Copy App ID", systemImage: "doc.on.doc")
                        }
                    }

                if let trackName = appDetails.trackName {
                    Text(trackName)
                        .font(.largeTitle)
                        .bold()
                }

                // Bundle ID with tap-to-copy functionality
                if let bundleId = appDetails.bundleId {
                    Text("Bundle ID: \(bundleId)")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            copyToClipboard(bundleId)
                        }
                        .contextMenu {
                            Button {
                                copyToClipboard(bundleId)
                            } label: {
                                Label("Copy Bundle ID", systemImage: "doc.on.doc")
                            }
                        }
                }

                if let version = appDetails.version {
                    Text("Version: \(version)")
                        .font(.subheadline)
                }

                if let releaseDate = appDetails.releaseDate {
                    Text("Release Date: \(releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Divider()

                // Description with clickable URLs
                DisclosureGroup(isExpanded: $isDescriptionCollapsed) {
                    if let description = appDetails.description {
                        Text(description)
                    } else {
                        Text("No Description Available")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                } label: {
                    Text("Description")
                        .font(.title2)
                        .bold()
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("App Details")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    openInAppStore(appId: appDetails.searchedAppId)
                }) {
                    Label("Open in App Store", systemImage: "arrow.up.right.square")
                }
            }
        }
    }

    private func copyToClipboard(_ text: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
    }

    private func openInAppStore(appId: String) {
        let urlString = "https://apps.apple.com/app/\(appId)"
        if let url = URL(string: urlString) {
            if NSWorkspace.shared.open(url) {
                print("App Store opened successfully.")
            } else {
                print("Failed to open App Store.")
            }
        }
    }
}

#Preview {
    AppDetailView(appDetails: .init(from: [:], searchedAppId: "123456789"))
}
