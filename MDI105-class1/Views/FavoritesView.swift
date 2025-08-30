//
//  FavoritesView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//
import SwiftUI
import SwiftData

struct FavoritesView: View {
    
    @Query(filter: #Predicate<PersistentBook> { $0.isFavorite == true })
    var favoriteBooks: [PersistentBook]

    // Two-column grid layout as specified
    private var gridLayout: [GridItem] {
        [
            GridItem(.flexible(), spacing: 8),
            GridItem(.flexible(), spacing: 8)
        ]
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                if favoriteBooks.isEmpty {
                    // Empty state
                    VStack(spacing: 16) {
                        Image(systemName: "heart")
                            .font(.system(size: 60))
                            .foregroundStyle(.secondary)
                        Text("No Favorites Yet")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text("Books you favorite will appear here")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                } else {
                    // Grid of favorite books
                    ScrollView {
                        LazyVGrid(columns: gridLayout, spacing: 16) {
                            ForEach(favoriteBooks) { book in
                                NavigationLink {
                                    DetailView(book: book)
                                } label: {
                                    SquareCardView(book: book)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    }
                }
            }
            .navigationTitle("Favorite Books")
        }
    }
}

#Preview {
    FavoritesView()
        .modelContainer(for: [PersistentBook.self, UploadedImage.self])
}
