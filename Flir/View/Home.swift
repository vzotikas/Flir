import SwiftUI

struct Home: View {
    @StateObject var homeData = DataViewModel()

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
