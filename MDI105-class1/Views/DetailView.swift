//
//  DetailView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 06/08/25.
//

import SwiftUI

struct DetailView: View {
    @Binding var book: Book
    @State private var showingEditSheet = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.1), .gray.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack{
                        Image(book.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100, maxHeight: 150)
                            .padding(.vertical,20)
                        VStack{
                            Text(book.title)
                                .font(.system(size: 36, weight: .bold, design: .serif))
                            
                            Text("by \(String(describing: book.author))")
                                .font(.headline).foregroundColor(.secondary)
                        }
                    }

                    HStack {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= book.rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                    .accessibilityLabel("\(String(describing: book.rating)) out of 5 stars") // Simple label for the stars
                    
                    Text(book.status.rawValue)
                        .font(.caption).fontWeight(.bold).padding(8)
                        .background(Color.accentColor.opacity(0.2)).clipShape(Capsule())
                    
                    if !book.review.isEmpty {
                        VStack(alignment: .leading) {
                            Text(book.description)
                        }
                    }
                    
                    if !book.review.isEmpty {
                        VStack(alignment: .leading) {
                            Text("My Review").font(.title2).fontWeight(.bold)
                            Text(book.review)
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
                Button("Edit") { showingEditSheet = true }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            EditView(book: $book)
        }
    }
}

