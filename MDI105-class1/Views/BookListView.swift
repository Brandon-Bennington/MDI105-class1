//
//  BookListView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

struct BookListView: View {

    @Binding var books: [Book]
    @State private var activeSheet: ActiveSheet? = nil
    @State var selectedGenre: Genre?
    @State var selectedStatus: ReadingStatus?
    @State private var newBook = NEW_BOOK
    
    private var filteredBooks: [Book] {
        books.filter { book in
            var matches = true
            if let genre = selectedGenre {
                matches = matches && book.genre == genre
            }
            if let status = selectedStatus {
                matches = matches && book.status == status
            }
            return matches
        }
    }

    var body: some View {
        NavigationStack {
            List(filtered) { book in
                NavigationLink {
                    DetailView(book: book)
                } label: {
                    HStack(spacing: 12) {
                        Image(book.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 44, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(book.title).font(.headline)
                            HStack(spacing: 8) {
                                Text(book.genre.rawValue)
                                Text("•")
                                Text(book.status.rawValue)
                            }
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                        }
                        Spacer()
                        if book.isFavorite {
                            Image(systemName: "heart.fill").foregroundStyle(.pink)
                        }
                    }
                }
            }
            .navigationTitle("Books")
            .searchable(text: $search, prompt: "Search by title")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        FavoritesView(books: $books)
                    } label: {
                        Label("Favorites", systemImage: "heart")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresentingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAdd) {
                AddEditView()
                    .presentationDetents([.medium, .large])
            }
        }
    }
}
