import SDWebImageSwiftUI
import SwiftUI

struct ReposView: View {
    @ObservedObject var vm = HomeViewModel()
    @EnvironmentObject var homeData: HomeViewModel
    @State var showRepoDetailModalView: Bool = false
    @State var selectionIndex: Int = 0
    @Environment(\.colorScheme) var colorScheme
    let colorTheme: ColorThemeProtocol = DefaultColorTheme()

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                if homeData.fetchedReposList.isEmpty {
                    ProgressView()
                        .padding(.top, 30)
                }
                else {
                    // Dispaying Contents...
                    VStack(spacing: 10) {
                        ForEach(homeData.fetchedReposList.indices) { repoIndex in

                            Button(action: { selectionIndex = repoIndex
                                showRepoDetailModalView = true
                            }) {
                                HStack(alignment: .center, spacing: 15) {
                                    WebImage(url: URL(string: "\(self.homeData.fetchedReposList[repoIndex].avatar_url)"))
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        .shadow(radius: 10)

                                    HStack(alignment: .center, spacing: 0, content: {
                                        Text(self.homeData.fetchedReposList[repoIndex].login)
                                            .font(.title3)
                                            .foregroundColor(Color.white)
                                            .fontWeight(.bold)
                                            .accessibility(identifier: "repoName\(repoIndex)")
                                        Spacer()

                                    })
                                }
                                .padding()
//                                .background(colorScheme == .dark ? colorTheme.tertiaryColor : colorTheme.primaryColor)
                                .background(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.5890869692147497, saturation: 0.7570247420345445, brightness: 0.3924503096614976, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.6, saturation: 1.0, brightness: 0.12792784909167923, opacity: 1.0), location: 0.507611553485577), Gradient.Stop(color: Color(hue: 0.8346959309405592, saturation: 1.0, brightness: 0.3181611945830196, opacity: 1.0), location: 1.0)]), startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing))
                                .cornerRadius(20)
                                .shadow(color: colorTheme.quaternaryColor, radius: 4)
                            }
                            .sheet(isPresented: $showRepoDetailModalView) {
                                RepoDetailView(isPresented: $showRepoDetailModalView, selectionIndex: $selectionIndex)
                            }
                            .accessibility(identifier: "infoButton\(repoIndex)")
                        }
                    }
                    .padding()
                    Button("Logout") {
                        vm.logoutUser()
                    }
                    .padding()
                    .frame(width: 100, height: 40, alignment: .center)
                    .background(colorTheme.primaryColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            })
//                .background(colorTheme.tertiaryColor)
            .navigationTitle("Repos List")
        }
        // Loading Data...
        .onAppear(perform: {
            if homeData.fetchedReposList.isEmpty {
                Task {
                    await homeData.fetchRepos()
                }
            }
        })
    }
}
