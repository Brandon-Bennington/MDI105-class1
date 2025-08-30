//
//  BookListView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Query var books: [PersistentBook]
    @Environment(\.modelContext) var modelContext
    
    @State private var showingAddSheet = false
    @State private var showingFiltersSheet = false
    @State private var searchText = ""
    @State private var selectedGenre: Genre?
    @State private var selectedStatus: ReadingStatus?
    
    private var filteredBooks: [PersistentBook] {
        books.filter { book in
            // Search filter
            let matchesSearch = searchText.isEmpty ||
                book.title.localizedCaseInsensitiveContains(searchText) ||
                book.author.localizedCaseInsensitiveContains(searchText)
            
            // Genre filter
            let matchesGenre = selectedGenre == nil || book.genre == selectedGenre
            
            // Status filter
            let matchesStatus = selectedStatus == nil || book.status == selectedStatus
            
            return matchesSearch && matchesGenre && matchesStatus
        }
    }
    
    private var favoriteBooks: [PersistentBook] {
        books.filter { $0.isFavorite }
    }

    var body: some View {
        NavigationStack {
            List(filteredBooks) { book in
                NavigationLink {
                    DetailView(book: book)
                } label: {
                    BookRowView(book: book)
                }
            }
            .navigationTitle("Books")
            .searchable(text: $searchText, prompt: "Search by title or author")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        FavoritesView()
                    } label: {
                        Label("Favorites", systemImage: "heart")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            showingFiltersSheet = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                        
                        Button {
                            showingAddSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddEditView()
            }
            .sheet(isPresented: $showingFiltersSheet) {
                FiltersView(
                    selectedGenre: $selectedGenre,
                    selectedStatus: $selectedStatus
                )
            }
        }
    }
}

// Simple row view for the list
private struct BookRowView: View {
    let book: PersistentBook
    
    private var bookImage: UIImage? {
        guard let coverImage = book.coverImage,
              let imageData = coverImage.imageData else {
            return UIImage(systemName: "book")
        }
        return UIImage(data: imageData)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(uiImage: bookImage ?? UIImage(systemName: "book")!)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .shadow(radius: 1)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("by \(book.author)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                HStack(spacing: 8) {
                    Text(book.genre.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.blue.opacity(0.1))
                        .clipShape(Capsule())
                    
                    Text(book.status.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.green.opacity(0.1))
                        .clipShape(Capsule())
                }
            }
            
            Spacer()
            
            VStack(spacing: 4) {
                if book.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.pink)
                        .font(.caption)
                }
                
                if book.rating > 0 {
                    HStack(spacing: 1) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.caption2)
                        Text("\(book.rating)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    BookListView()
        .modelContainer(for: [PersistentBook.self, UploadedImage.self])
}
