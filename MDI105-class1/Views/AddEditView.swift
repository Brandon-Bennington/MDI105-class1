//
//  AddEditView.swift
//  MDI105_class2_demo
//
//  Created by <Your Name> on <Date>.
//

import SwiftUI
import PhotosUI
import SwiftData

struct AddEditView: View {
    @Binding var book: Book
    @State private var bookCopy: Book

    @Environment(\.dismiss) var dismiss
    
    @State private var navigationTitle: String
    
    //Image related variables
    @Environment(\.modelContext) var modelContext
    @State var bookImage: UIImage?
    @State private var photoPickerItem: PhotosPickerItem?

    // A custom initializer to set the title when the view is first created.
    init(book: Binding<Book>) {
        // The underscore `_book` refers to the Binding property wrapper itself.
        self._book = book

        // The underscore `_navigationTitle` refers to the State property wrapper.
        // We set its initial value based on the book's state at this moment.
        self._navigationTitle = State(initialValue: book.wrappedValue.title.isEmpty
                                      ? "Add Book"
                                      : "Edit Book")

        // condition ? if_true : if_false → ternary operator
        bookCopy = book.wrappedValue
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book cover")) {
                    PhotosPicker(
                        selection: $photoPickerItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        
                        Image(uiImage: bookImage ?? UIImage(resource: .defaultBook))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    .onChange(of: photoPickerItem) { _,_ in
                        Task {
                            if let photoPickerItem,
                               let imageData = try? await photoPickerItem.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: imageData) {
                                    self.bookImage = uiImage
                                }
                            }
                            
                        }
                    }
                }
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $bookCopy.title)
                    TextField("Author", text: $bookCopy.author)

                    Picker("Status", selection: $bookCopy.status) {
                        ForEach(ReadingStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }

                    TextEditor(text: $bookCopy.description)
                        .frame(height: 120)
                }

                Section(header: Text("My Rating & Review")) {
                    StarRatingView(rating: $bookCopy.rating)
                    TextEditor(text: $bookCopy.review)
                        .frame(height: 150)
                }

                Section {
                    Toggle("Favorite", isOn: $bookCopy.isFavorite)
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        // Discard changes
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Copy draft back into binding
                        if bookImage != nil {
                            let newUploadedImage = UploadedImage(imageData: bookImage?.jpegData(compressionQuality: 0.8))
                            modelContext.insert(newUploadedImage)
                            do {
                                try modelContext.save()
                            } catch {
                                print("Error while saving the image: \(error)")
                            }
                            bookCopy.imageID = newUploadedImage.persistentModelID
                            let _ = print("New image id: \(newUploadedImage.persistentModelID)")
                            
                        }
                        book = bookCopy
                        dismiss()
                    }
                }
            }
        }
    }
}
