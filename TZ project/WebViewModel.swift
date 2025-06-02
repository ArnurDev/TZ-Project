import Foundation
import FirebaseRemoteConfig
import SwiftUI

class WebViewModel: ObservableObject {
    @Published var showWebView: Bool = false
    @Published var savedURL: URL? = nil
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    private let savedKey = "SavedWebViewURL"
    
    init() {
        print("WebViewModel init")
        loadSavedURL()
        fetchRemoteConfig()
    }
    
    /// Загружает сохранённую ссылку из UserDefaults (если она есть)
    private func loadSavedURL() {
        if let urlString = UserDefaults.standard.string(forKey: savedKey),
           let url = URL(string: urlString) {
            self.savedURL = url
            self.showWebView = true
            print("Loaded saved URL from UserDefaults: \(url.absoluteString)")
        } else {
            print("No saved URL in UserDefaults")
        }
    }
    
    /// Запрашивает параметры из RemoteConfig и обновляет состояние
    private func fetchRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        remoteConfig.fetchAndActivate { [weak self] status, error in
            guard let self = self else { return }

            if let error = error {
                print("RemoteConfig fetch error: \(error.localizedDescription)")
            }

            let needForceUpdate = self.remoteConfig["needForceUpdate"].boolValue
            let redirectLink = self.remoteConfig["redirectLink"].stringValue ?? ""

            print("RemoteConfig fetched — needForceUpdate: \(needForceUpdate), redirectLink: \(redirectLink)")

            if needForceUpdate, let url = URL(string: redirectLink) {
                DispatchQueue.main.async {
                    UserDefaults.standard.set(url.absoluteString, forKey: self.savedKey)
                    self.savedURL = url
                    self.showWebView = true
                    print("Saved URL set from RemoteConfig: \(url.absoluteString)")
                    print("showWebView set to true due to RemoteConfig")
                }
            } else {
                print("RemoteConfig: needForceUpdate is false, not changing showWebView or savedURL")
                // Не сбрасываем showWebView, чтобы не скрывать WebView если URL уже есть
            }
        }
    }
    
    /// Ручная установка тестового URL (для отладки)
    func manualOverride() {
        DispatchQueue.main.async {
            let testURL = URL(string: "https://en.wikipedia.org/wiki/The_Lord_of_the_Rings")!
            UserDefaults.standard.set(testURL.absoluteString, forKey: self.savedKey)
            self.savedURL = testURL
            self.showWebView = true
            print("Manual override: showWebView = true with test URL")
        }
    }
    
    /// Сброс отображения WebView (например, при закрытии)
    func reset() {
        print("Reset called - hiding WebView")
        self.showWebView = false
    }
}
