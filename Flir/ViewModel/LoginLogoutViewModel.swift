import Combine
import Firebase
import SwiftUI

class LoginLogoutViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    var errorMessage = ""
    var myError = ""
    var authenticationSucceded = false
}

extension LoginLogoutViewModel {
    func logoutUser() {
        AppManager.Authenticated.send(false)
    }

    func loginUser() async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)

            authenticationSucceded = true

            AppManager.Authenticated.send(true)

        } catch {
            print(error.localizedDescription)
            myError = error.localizedDescription
        }
    }
}
