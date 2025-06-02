import SwiftUI

struct CharactersView: View {
    @StateObject var viewModel = CharacterViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.characters) { character in
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        CharacterGridItemView(character: character)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Characters")
        .onAppear {
            viewModel.fetchCharacters()
        }
    }
}
