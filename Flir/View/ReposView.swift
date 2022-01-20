import SDWebImageSwiftUI
import SwiftUI

struct ReposView: View {
    @ObservedObject var logoutViewModel = LoginLogoutViewModel()
    @EnvironmentObject var repoData: DataViewModel
    @State var showRepoDetailModalView: Bool = false
    @State var selectionIndex: Int = 0
    @Environment(\.colorScheme) var colorScheme
    let colorTheme: ColorThemeProtocol = DefaultColorTheme()

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                if repoData.fetchedReposList.isEmpty {
                    ProgressView()
                        .padding(.top, 30)
                }
                else {
                    // Dispaying Contents...
                    VStack(spacing: 10) {
                        ForEach(repoData.fetchedReposList.indices) { repoIndex in

                            Button(action: { selectionIndex = repoIndex
                                showRepoDetailModalView = true
                            }) {
                                HStack(alignment: .center, spacing: 15) {
                                    WebImage(url: URL(string: "\(self.repoData.fetchedReposList[repoIndex].avatar_url)"))
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        .shadow(radius: 10)

                                    HStack(alignment: .center, spacing: 0, content: {
                                        Text(self.repoData.fetchedReposList[repoIndex].login)
                                            .font(.title3)
                                            .foregroundColor(Color.white)
                                            .fontWeight(.bold)
                                            .accessibility(identifier: "repoName\(repoIndex)")
                                        Spacer()

                                    })
                                }
                                .padding()
//                                .background(colorScheme == .dark ? colorTheme.tertiaryColor : colorTheme.primaryColor)
                                .background(colorTheme.gradient)
                                .cornerRadius(20)
                                .shadow(color: colorTheme.quaternaryColor, radius: 4)
                            }.accessibility(identifier: "infoButton\(String(repoIndex))")
                                .sheet(isPresented: $showRepoDetailModalView) {
                                    RepoDetailView(isPresented: $showRepoDetailModalView, selectionIndex: $selectionIndex)
                                }
                        }
                    }
                    .padding()
                    Button("Logout") {
                        logoutViewModel.logoutUser()
                    }
                    .accessibilityIdentifier("logoutButton")
                    .padding()
                    .frame(width: 100, height: 40, alignment: .center)
                    .background(colorTheme.primaryColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            })
//            .background(colorTheme.tertiaryColor)
            .navigationTitle("Repos List")
        }
        // Loading Data...
        .onAppear(perform: {
            if repoData.fetchedReposList.isEmpty {
                Task {
                    await repoData.fetchRepos()
                }
            }
        })
    }
}

// struct ReposView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReposView()
//    }
// }
