//
//  MainTabView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 25/08/25.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [PersistentBook]
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Books")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
        }
        .onAppear {
            // Add sample books only if the database is empty
            if books.isEmpty {
                addSampleBooks()
            }
        }
    }
    
    // Function to add sample LOTR books on first launch
    private func addSampleBooks() {
        let sampleBooks = [
            ("The Fellowship of the Ring", "In a sleepy village in the Shire, a young hobbit is entrusted with an immense task. He must make a perilous journey across Middle-earth to the Cracks of Doom, there to destroy the Ruling Ring of Power - the only thing that prevents the Dark Lord's evil dominion.", false), // No favorites by default
            ("The Two Towers", "The Fellowship has broken. Frodo and Sam continue their dangerous journey toward Mordor, guided by the treacherous Gollum. Meanwhile, Aragorn, Legolas, and Gimli pursue the Uruk-hai who captured Merry and Pippin.", false),
            ("The Return of the King", "The final volume of the epic trilogy brings the War of the Ring to its climactic conclusion. As Frodo and Sam approach Mount Doom on their final desperate mission to destroy the Ring, Aragorn must claim his destiny as the rightful king.", false)
        ]
        
        for (title, description, isFavorite) in sampleBooks {
            let book = PersistentBook(
                title: title,
                author: "J.R.R. Tolkien",
                description: description,
                genre: .fantasy,
                isFavorite: isFavorite
            )
            modelContext.insert(book)
        }
        
        try? modelContext.save()
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: [PersistentBook.self, UploadedImage.self])
}
