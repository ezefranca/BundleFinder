import Foundation
import SwiftUI

class AppDetailsViewModel: ObservableObject {
    @Published var history: [AppDetails] = []
    @Published var selectedApp: AppDetails?

    @Published var showToast: Bool = false
    @Published var toastMessage: String = ""

    private let networkManager: NetworkManager
    private let historyKey = "appHistory"

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
        loadHistory()
    }

    func fetchAppDetails(appId: String) {
        Task {
            await networkManager.fetchAppDetails(appId: appId) { [weak self] details in
                guard let self = self, let details = details else { return }
                DispatchQueue.main.async {
                    let newDetails = AppDetails(from: details.dictionaryRepresentation(), searchedAppId: appId)
                    self.history.append(newDetails)
                    self.saveHistory()
                    self.selectedApp = newDetails
                }
            }
        }
    }

    func deleteApp(at offsets: IndexSet) {
        history.remove(atOffsets: offsets)
        saveHistory()
        showToast(with: "App removed from history.")
    }

    func deleteApp(_ app: AppDetails) {
        if let index = history.firstIndex(where: { $0.id == app.id }) {
            history.remove(at: index)
            saveHistory()
            showToast(with: "App removed from history.")
        }
    }

    func deleteAllHistory() {
        history.removeAll()
        saveHistory()
        showToast(with: "All history deleted.")
    }

    func exportHistory() -> URL? {
        let fileManager = FileManager.default
        let tempDir = fileManager.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent("AppHistory.json")

        do {
            let data = try JSONEncoder().encode(history)
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Failed to export history: \(error.localizedDescription)")
            return nil
        }
    }

    private func saveHistory() {
        do {
            let data = try JSONEncoder().encode(history)
            UserDefaults.standard.set(data, forKey: historyKey)
        } catch {
            print("Failed to save history: \(error.localizedDescription)")
        }
    }

    private func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: historyKey) {
            do {
                history = try JSONDecoder().decode([AppDetails].self, from: data)
            } catch {
                print("Failed to load history: \(error.localizedDescription)")
            }
        }
    }

    private func showToast(with message: String) {
        toastMessage = message
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
}
