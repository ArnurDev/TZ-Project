import SwiftUI
import FirebaseCore

@main
struct TZ_projectApp: App {
    @StateObject var webVM = WebViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(webVM) 
        }
    }
}


