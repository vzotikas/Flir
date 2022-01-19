import Combine
import SwiftUI

struct LoginView: View {
    @ObservedObject var loginViewModel = LoginLogoutViewModel()
    @State var showAlert = false
    let colorTheme: ColorThemeProtocol = DefaultColorTheme()

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)

            VStack {
                TextField("Email", text: $loginViewModel.email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            VStack {
                SecureField("Password", text: $loginViewModel.password)
                    .textContentType(.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            Button("Login") {
                Task {
                    await loginViewModel.loginUser()

                    if loginViewModel.authenticationSucceded == true {
                        print("ax")
                        showAlert = false
                    } else {
                        print("ox")
                        showAlert = true
                    }
                }
            }
            .padding()
            .frame(width: 100, height: 40, alignment: .center)
            .background(colorTheme.primaryColor)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text(loginViewModel.myError))
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
