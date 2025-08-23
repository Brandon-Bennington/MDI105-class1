//
//  BookListView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

struct BookListView: View {
    @Binding var books: [Book]
    @State private var search = ""
    @State private var isPresentingAdd = false

    private var filtered: [Book] {
        guard !search.isEmpty else { return books }
        let q = search.lowercased()
        return books.filter { $0.title.lowercased().contains(q) }
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
