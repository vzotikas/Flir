import SwiftUI

struct GrowingButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    let colorTheme: ColorThemeProtocol = DefaultColorTheme()
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(colorTheme.primaryColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct RepoDetailView: View {
    @Binding var isPresented: Bool
    @Binding var selectionIndex: Int
    @EnvironmentObject var homeData: DataViewModel
    @Environment(\.colorScheme) var colorScheme
    let colorTheme: ColorThemeProtocol = DefaultColorTheme()
    
    var body: some View {
        let selectedRepo = self.homeData.fetchedReposList[selectionIndex]
        
        VStack {
            VStack {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding()
                Text(selectedRepo.login)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                
                if (selectedRepo.html_url) != nil {
                    if (selectedRepo.html_url?.hasPrefix("https://")) == true {
                        Text("**website** \n\(selectedRepo.html_url ?? "")")
                            .padding()
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Link("Go to website", destination: URL(string: selectedRepo.html_url ?? "")!)
                            .padding()
                            .foregroundColor(colorTheme.primaryColor)
                            .clipShape(Capsule())
                    } else {
                        Text("**website** \n\(selectedRepo.html_url ?? "")")
                            .padding()
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Link("Go to website", destination: URL(string: "http://" + (selectedRepo.html_url ?? ""))!)
                            .padding()
                            .foregroundColor(colorTheme.primaryColor)
                            .clipShape(Capsule())
                    }
                }
                
                Button(action: {
                    isPresented = false
                }, label: {
                    Label("Close", systemImage: "xmark.circle")
                }).buttonStyle(GrowingButton())
                    .padding()
                    .accessibility(identifier: "infoCloseButton")
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
            )
            .background(colorTheme.gradient)
        }
    }
}
