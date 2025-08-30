//
//  DetailView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 06/08/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let book: PersistentBook
    @State private var showingEditSheet = false
    @Environment(\.modelContext) var modelContext
    
    private var bookImage: UIImage? {
        guard let coverImage = book.coverImage,
              let imageData = coverImage.imageData else {
            return UIImage(systemName: "book")
        }
        return UIImage(data: imageData)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray.opacity(0.1), .gray.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Book cover and title section
                    HStack(alignment: .top, spacing: 16) {
                        Image(uiImage: bookImage ?? UIImage(systemName: "book")!)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 120, maxHeight: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(radius: 4)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(book.title)
                                .font(.system(size: 28, weight: .bold, design: .serif))
                                .multilineTextAlignment(.leading)
                            
                            Text("by \(book.author)")
                                .font(.title3)
                                .foregroundColor(.secondary)
                            
                            // Genre and status badges
                            HStack {
                                Text(book.genre.rawValue)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(.blue.opacity(0.2))
                                    .clipShape(Capsule())
                                
                                Text(book.status.rawValue)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.accentColor.opacity(0.2))
                                    .clipShape(Capsule())
                            }
                            
                            // Favorite toggle button
                            Button {
                                book.isFavorite.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                                        .foregroundStyle(book.isFavorite ? .pink : .secondary)
                                    Text(book.isFavorite ? "Favorited" : "Add to Favorites")
                                        .font(.caption)
                                        .foregroundStyle(book.isFavorite ? .pink : .secondary)
                                }
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel(book.isFavorite ? "Remove from favorites" : "Add to favorites")
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 20)

                    // Rating section
                    if book.rating > 0 {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("My Rating")
                                .font(.headline)
                            
                            HStack {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= book.rating ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                        .font(.title3)
                                }
                                Text("(\(book.rating)/5)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .accessibilityLabel("\(book.rating) out of 5 stars")
                    }
                    
                    // Description section
                    if !book.description.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.headline)
                            
                            Text(book.description)
                                .font(.body)
                                .lineSpacing(2)
                        }
                    }
                    
                    // Review section
                    if !book.review.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("My Review")
                                .font(.headline)
                            
                            Text(book.review)
                                .font(.body)
                                .lineSpacing(2)
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEditSheet = true
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            AddEditView(book: book)
        }
    }
}

#Preview {
    let sampleBook = PersistentBook(
        title: "The Fellowship of the Ring",
        author: "J.R.R. Tolkien",
        description: "In a sleepy village in the Shire, a young hobbit is entrusted with an immense task. He must make a perilous journey across Middle-earth to the Cracks of Doom, there to destroy the Ruling Ring of Power.",
        genre: .fantasy,
        rating: 5,
        review: "An absolutely masterful beginning to the greatest fantasy epic ever written. Tolkien's world-building is unparalleled.",
        isFavorite: true
    )
    
    NavigationView {
        DetailView(book: sampleBook)
    }
    .modelContainer(for: [PersistentBook.self, UploadedImage.self])
}
