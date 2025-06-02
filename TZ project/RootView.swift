import SwiftUI

struct RootView: View {
    struct RootView: View {
        var body: some View {
            WebViewScreen()
        }
    }

    @EnvironmentObject var webVM: WebViewModel

    var body: some View {
        Group {
            if webVM.showWebView, let url = webVM.savedURL {
                WebViewScreen()
            } else {
                mainTabView
            }
        }
    }

    private var mainTabView: some View {
        TabView {
            NavigationStack {
                CharactersView()
            }
            .tabItem {
                Label("Characters", systemImage: "person.3.fill")
            }

            Text("Locations Screen Placeholder")
                .tabItem {
                    Label("Locations", systemImage: "globe")
                }

            Text("Episodes Screen Placeholder")
                .tabItem {
                    Label("Episodes", systemImage: "film")
                }

            Text("Settings Screen Placeholder")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
