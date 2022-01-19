import SwiftUI

// Model...
struct APIRepoData: Codable {
    var repo: [Repo]
}

struct Repo: Identifiable, Codable {
    var id: UUID { UUID() }
    var login: String
    var avatar_url: String
    var html_url: String?
}
