import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()

    var body: some View {
        ReposView()
            .environmentObject(homeData)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
