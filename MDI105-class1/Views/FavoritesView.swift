//
//  FavoritesView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//
import SwiftUI

struct FavoritesView: View {

    @Binding var books: [Book]

    @State private var isShowingFiltersSheet: Bool = false
    @State private var selectedGenre: Genre?
    @State private var selectedStatus: ReadingStatus?

    // ← READ the user’s setting from SettingsView
    @AppStorage(GRID_COLUMN_NUMBERS_KEY) private var gridColumnNumber: Int = 2

    // ← Build a dynamic grid layout from the setting (guard rails 1...6)
    private var gridLayout: [GridItem] {
        let cols = max(1, min(gridColumnNumber, 6))
        return Array(repeating: GridItem(.flexible(), spacing: 16), count: cols)
    }

    private var favoriteBooks: [Binding<Book>] {
        $books.filter {
            $0.wrappedValue.isFavorite
            && (selectedGenre == nil || $0.wrappedValue.genre  == selectedGenre!)
            && (selectedStatus == nil || $0.wrappedValue.status == selectedStatus!)
        }
    }

    var body: some View {
        let _ = print("re-rendering FavoritesView",
                      selectedGenre?.rawValue ?? "no-genre",
                      selectedStatus?.rawValue ?? "no-status")

        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridLayout, spacing: 16) {
                    ForEach(favoriteBooks) { $book in
                        NavigationLink {
                            BookDetailView(book: $book)
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                RoundedRectangle(cornerRadius: 12)
                                    .aspectRatio(3/4, contentMode: .fit)
                                    .opacity(0.15)

                                Text(book.genre.rawValue).font(.headline)
                                Text(book.status.rawValue)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(8)
                            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14))
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Favorites")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if selectedGenre != nil || selectedStatus != nil {
                        Button("Clear") { selectedGenre = nil; selectedStatus = nil }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { isShowingFiltersSheet = true } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .sheet(isPresented: $isShowingFiltersSheet) {
                FiltersView(
                    selectedGenre: $selectedGenre,
                    selectedStatus: $selectedStatus
                )
            }
        }
        // Smoothly animate when user changes the number of columns in Settings
        .animation(.default, value: gridColumnNumber)
    }
}

// Simple detail view that only touches known fields
private struct BookDetailView: View {
    @Binding var book: Book
    var body: some View {
        Form {
            Toggle("Favorite", isOn: $book.isFavorite)
            HStack { Text("Genre");  Spacer(); Text(book.genre.rawValue).foregroundStyle(.secondary) }
            HStack { Text("Status"); Spacer(); Text(book.status.rawValue).foregroundStyle(.secondary) }
        }
        .navigationTitle("Book")
    }
}

