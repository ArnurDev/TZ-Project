import Foundation
import FirebaseRemoteConfig
import SwiftUI

class WebViewModel: ObservableObject {
    @Published var showWebView: Bool = false
    @Published var savedURL: URL? = nil
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    private let savedKey = "SavedWebViewURL"
    
    init() {
        loadSavedURL()
        fetchRemoteConfig()
    }
    
    /// Загружает сохранённую ссылку из UserDefaults (если она есть)
    private func loadSavedURL() {
        if let urlString = UserDefaults.standard.string(forKey: savedKey),
           let url = URL(string: urlString) {
            self.savedURL = url
            self.showWebView = true // приоритет сохранённой ссылки
        }
    }
    
    private func fetchRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        remoteConfig.fetchAndActivate { [weak self] status, error in
            guard let self = self else { return }

            let needForceUpdate = self.remoteConfig["needForceUpdate"].boolValue
            let redirectLink = self.remoteConfig["redirectLink"].stringValue ?? ""

            print("RemoteConfig — needForceUpdate: \(needForceUpdate), link: \(redirectLink)")

            if needForceUpdate, let url = URL(string: redirectLink) {
                DispatchQueue.main.async {
                    if self.savedURL == nil {
                        UserDefaults.standard.set(url.absoluteString, forKey: self.savedKey)
                        self.savedURL = url
                    }
                    self.showWebView = true
                }
            } else {
                print("RemoteConfig: Показываем заглушку")
            }
        }
    }

    /// Возврат к приложению (для тестов)
    func reset() {
        self.showWebView = false
    }
}
        
