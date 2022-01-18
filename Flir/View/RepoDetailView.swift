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
    @EnvironmentObject var homeData: HomeViewModel
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
                .background(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.5890869692147497, saturation: 0.7570247420345445, brightness: 0.3924503096614976, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.6, saturation: 1.0, brightness: 0.12792784909167923, opacity: 1.0), location: 0.507611553485577), Gradient.Stop(color: Color(hue: 0.8346959309405592, saturation: 1.0, brightness: 0.3181611945830196, opacity: 1.0), location: 1.0)]), startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing))
        }
    }
}
