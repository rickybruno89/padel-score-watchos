import SwiftUI

struct PagesView: View {
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        TabView(selection: $sharedData.selectedTab) {
            PageOneView().tag(1)
            PageTwoView().tag(2)
            PageThreeView().tag(3)
        }
    }
}

struct PagesView_Previews: PreviewProvider {
    static var previews: some View {
        PagesView()
    }
}
