import Combine
import Foundation
import SwiftUI

class DataViewModel: ObservableObject {
    @Published var fetchedReposList: [Repo] = []

//    func fetchRepos() async {
//        let url = URL(string: "https://api.github.com/users?per_page=10")!
//        let urlSession = URLSession.shared
//        do {
//            let (data, _) = try await urlSession.data(from: url)
//
//            let repos = try! JSONDecoder().decode([Repo].self, from: data)
//            DispatchQueue.main.async {
//                self.fetchedReposList = repos
//                self.fetchedReposList.sort {
//                    ($0.login) <
//                        ($1.login)
//                }
//            }
//        }
//        catch {
//            debugPrint("Error loading \(url): \(String(describing: error))")
//        }
//    }
    
    func fetchRepos() async {
        let url = "https://api.github.com/users?per_page=10"
        let session = URLSession(configuration: .default)

        session.dataTask(with: URL(string: url)!) { data, _, err in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            guard let APIData = data else {
                print("no data found")
                return
            }
            do {
                // Decoding API Data...
                let repos = try JSONDecoder().decode([Repo].self, from: APIData)

                DispatchQueue.main.async {
                    self.fetchedReposList = repos
                    self.fetchedReposList.sort {
                        ($0.login) <
                            ($1.login)
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
