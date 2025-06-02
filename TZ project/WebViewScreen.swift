import SwiftUI

struct WebViewScreen: View {
    @EnvironmentObject var webVM: WebViewModel
    @State private var isLoading = true

    var body: some View {
        VStack {
            if let url = webVM.savedURL {
                ZStack {
                    WebView(url: url, isLoading: $isLoading)

                    if isLoading {
                        ProgressView("Загрузка…")
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                    }
                }
            }

            Button("Назад к приложению") {
                webVM.reset()
            }
            .padding()
            .foregroundColor(.blue)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
