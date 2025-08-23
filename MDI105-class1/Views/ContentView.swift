//
//  ContentView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 06/08/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var books: [Book] = getBooks()
    @State private var showingAddBookSheet = false
    @State private var newBook = Book(title: "", author: "", image:"default_book", description: "", rating: 0, review: "", status: .planToRead)
    
    var body: some View {
        NavigationView {
            // Using a binding ($books) allows child views to directly modify the array.
            List($books) { $book in
                NavigationLink(destination: DetailView(book: $book)) {
                    LinkView(book: book)
                }
            }
            .navigationTitle("My Books")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddBookSheet = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    // ACCESSIBILITY: A button with only an icon is invisible to VoiceOver
                    // without a label. This is essential.
                    .accessibilityLabel("Add new book")
                }
            }
            // When `showingAddBookSheet` is true, this view slides up.
            .sheet(isPresented: $showingAddBookSheet) {
                if !newBook.title.isEmpty {
                    books.append(newBook)
                } else{
                   newBook = Book(title: "", author: "", image:"default_book", description: "", rating: 0, review: "", status: .planToRead)
                }
            } content: {
                EditView(book: $newBook)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
