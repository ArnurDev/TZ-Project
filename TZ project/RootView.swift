import SwiftUI

struct RootView: View {
    @EnvironmentObject var webVM: WebViewModel

    var body: some View {
        Group {
            if webVM.showWebView, let url = webVM.savedURL {
                WebViewScreen()
                    .onAppear {
                        print("RootView: showWebView = true, savedURL = \(url.absoluteString)")
                    }
            } else {
                mainTabView
                    .onAppear {
                        print("RootView: showWebView = false or savedURL is nil")
                    }
            }
        }
        .onAppear {
            print("RootView appeared - showWebView: \(webVM.showWebView), savedURL: \(String(describing: webVM.savedURL))")
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
