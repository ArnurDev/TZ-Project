import Foundation

struct Character: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
}

struct CharacterResponse: Codable {
    let results: [Character]
}

extension Character {
    static let mock1 = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "None", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")

    static let mock2 = Character(id: 2, name: "Morty Smith", status: "Alive", species: "Human",  type: "None", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
}
