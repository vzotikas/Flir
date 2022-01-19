import Combine
import Foundation

struct AppManager {
    static let Authenticated = PassthroughSubject<Bool, Never>()

    static var IsAuthenticated = false
}
