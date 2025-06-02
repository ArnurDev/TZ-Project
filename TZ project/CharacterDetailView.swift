import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipped()

                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 16) {
                    infoBox(title: "STATUS", value: character.status, systemImage: "bell", color: .blue)
                    infoBox(title: "GENDER", value: character.gender, systemImage: "bell.fill", color: .red)
                    infoBox(title: "TYPE", value: character.type.isEmpty ? "None" : character.type, systemImage: "bell.circle", color: .purple)
                    infoBox(title: "SPECIES", value: character.species, systemImage: "bell.badge", color: .green)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(character.name.uppercased())
        .navigationBarTitleDisplayMode(.inline)
    }

    private func infoBox(title: String, value: String, systemImage: String, color: Color) -> some View {
        VStack(spacing: 8) {
            Label {
                Text(value).bold()
            } icon: {
                Image(systemName: systemImage)
                    .foregroundColor(color)
            }

            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}
