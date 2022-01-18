import Combine
import SwiftUI
import Foundation

class HomeViewModel: ObservableObject {
    
    func logoutUser() {
        UserDefaults.standard.removeObject(forKey: "token")
        AppManager.Authenticated.send(false)
    }
    
    // Fetched Repo View Data...
    @Published var fetchedReposList: [Repo] = []


//    }

    func fetchRepos() async {

        let url = URL(string: "https://api.github.com/users?per_page=10")!
        let urlSession = URLSession.shared

        do {
            let (data, _) = try await urlSession.data(from: url)
            fetchedReposList = try JSONDecoder().decode([Repo].self, from: data)
            fetchedReposList.sort {
                ($0.login) <
                    ($1.login)
            }

            print(fetchedReposList)
        }
        catch {
            // Error handling in case the data couldn't be loaded
            // For now, only display the error on the console
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
}
