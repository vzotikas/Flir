import Combine
import Foundation
import SwiftUI

class DataViewModel: ObservableObject {
    @Published var fetchedReposList: [Repo] = []

    func fetchRepos() async {
        let url = URL(string: "https://api.github.com/users?per_page=10")!
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(from: url)

            let repos = try! JSONDecoder().decode([Repo].self, from: data)
            DispatchQueue.main.async {
                self.fetchedReposList = repos
                self.fetchedReposList.sort {
                    ($0.login) <
                        ($1.login)
                }
            }
        }
        catch {
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
}
