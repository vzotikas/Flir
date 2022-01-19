import Foundation
@testable import Flir
import XCTest

class ReposDataTest: XCTestCase {
    func testRepoData() throws {
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
                
                XCTAssertEqual("brynary", repos[1].login)
                XCTAssertEqual(repos.count, 10)
                
                for i in repos.indices {
                    XCTAssertEqual("", repos[i].html_url)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
