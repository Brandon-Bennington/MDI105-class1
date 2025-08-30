//
//  ContentView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 06/08/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // Use @Query to fetch all books from SwiftData
    @Query var books: [PersistentBook]
    
    @Environment(\.modelContext) var modelContext
    @State private var showingAddBookSheet = false
    
    var body: some View {
        NavigationView {
            List(books) { book in
                NavigationLink(destination: DetailView(book: book)) {
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
                    .accessibilityLabel("Add new book")
                }
            }
            .sheet(isPresented: $showingAddBookSheet) {
                AddEditView()
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: [PersistentBook.self, UploadedImage.self])
}
