import Foundation

class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []

    func fetchCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            if let decoded = try? JSONDecoder().decode(CharacterResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.characters = decoded.results
                }
            }
        }.resume()
    }
}
