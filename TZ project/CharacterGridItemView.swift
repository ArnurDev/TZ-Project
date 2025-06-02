import SwiftUI

struct CharacterGridItemView: View {
    let character: Character

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .aspectRatio(1, contentMode: .fill)
            .clipped()
            .cornerRadius(8)

            Text(character.name)
                .font(.headline)
                .lineLimit(1)

            Text("Status: \(character.status)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(4)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
