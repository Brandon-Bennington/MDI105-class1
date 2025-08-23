//
//  AddEditView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

struct EditView: View {
    @Binding var book: Book
    @Environment(\.dismiss) private var dismiss
    @State private var navigationTitle: String

    init(book: Binding<Book>) {
        self._book = book
        self._navigationTitle = State(
            initialValue: book.wrappedValue.title.isEmpty ? "Add Book" : "Edit Book"
        )
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $book.title)
                    TextField("Author", text: $book.author)

                    Picker("Status", selection: $book.status) {
                        ForEach(ReadingStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }

                    TextEditor(text: $book.description)
                        .frame(height: 150)
                } header: {
                    Text("Book Details")
                }

                Section {
                    StarRatingView(rating: $book.rating)
                    TextEditor(text: $book.review)
                        .frame(height: 150)
                } header: {
                    Text("My Rating & Review")
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { dismiss() }
                }
            }
        }
    }
}
