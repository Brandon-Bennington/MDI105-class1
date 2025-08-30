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
    // Optional book means we're editing, nil means we're adding
    let bookToEdit: PersistentBook?
    
    // Local state for form data
    @State private var title = ""
    @State private var author = ""
    @State private var bookDescription = ""
    @State private var rating = 0
    @State private var review = ""
    @State private var status = ReadingStatus.planToRead
    @State private var genre = Genre.fiction
    @State private var isFavorite = false
    
    // Image handling
    @State private var selectedImage: UIImage?
    @State private var photoPickerItem: PhotosPickerItem?
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    private var isEditing: Bool {
        bookToEdit != nil
    }
    
    private var navigationTitle: String {
        isEditing ? "Edit Book" : "Add Book"
    }
    
    // Initializer for adding new book
    init() {
        self.bookToEdit = nil
    }
    
    // Initializer for editing existing book
    init(book: PersistentBook) {
        self.bookToEdit = book
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Cover")) {
                    PhotosPicker(
                        selection: $photoPickerItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else if let bookImage = bookToEdit?.coverImage?.imageData,
                                  let uiImage = UIImage(data: bookImage) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Image(systemName: "book.closed")
                                .font(.system(size: 50))
                                .foregroundStyle(.secondary)
                                .frame(width: 100, height: 100)
                                .background(.gray.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    .onChange(of: photoPickerItem) { _, _ in
                        Task {
                            if let photoPickerItem,
                               let imageData = try? await photoPickerItem.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: imageData) {
                                selectedImage = uiImage
                            }
                        }
                    }
                }
                
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(Genre.allCases, id: \.self) { genre in
                            Text(genre.rawValue).tag(genre)
                        }
                    }

                    Picker("Status", selection: $status) {
                        ForEach(ReadingStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }

                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        TextEditor(text: $bookDescription)
                            .frame(height: 100)
                    }
                }

                Section(header: Text("My Rating & Review")) {
                    VStack(alignment: .leading) {
                        Text("Rating")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        StarRatingEditView(rating: $rating)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Review")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        TextEditor(text: $review)
                            .frame(height: 120)
                    }
                }

                Section {
                    Toggle("Favorite", isOn: $isFavorite)
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveBook()
                        dismiss()
                    }
                    .disabled(title.isEmpty || author.isEmpty)
                }
            }
            .onAppear {
                loadBookData()
            }
        }
    }
    
    private func loadBookData() {
        guard let book = bookToEdit else { return }
        
        title = book.title
        author = book.author
        bookDescription = book.description
        rating = book.rating
        review = book.review
        status = book.status
        genre = book.genre
        isFavorite = book.isFavorite
        
        // Load existing image if available
        if let coverImage = book.coverImage,
           let imageData = coverImage.imageData,
           let uiImage = UIImage(data: imageData) {
            selectedImage = uiImage
        }
    }
    
    private func saveBook() {
        if let existingBook = bookToEdit {
            // Update existing book
            existingBook.title = title
            existingBook.author = author
            existingBook.description = bookDescription
            existingBook.rating = rating
            existingBook.review = review
            existingBook.status = status
            existingBook.genre = genre
            existingBook.isFavorite = isFavorite
            
            // Handle image update
            if let newImage = selectedImage,
               let imageData = newImage.jpegData(compressionQuality: 0.8) {
                
                if let existingImage = existingBook.coverImage {
                    // Update existing image
                    existingImage.imageData = imageData
                } else {
                    // Create new image
                    let uploadedImage = UploadedImage(imageData: imageData)
                    modelContext.insert(uploadedImage)
                    existingBook.coverImage = uploadedImage
                }
            }
        } else {
            // Create new book
            let newBook = PersistentBook(
                title: title,
                author: author,
                description: bookDescription,
                genre: genre,
                rating: rating,
                review: review,
                status: status,
                isFavorite: isFavorite
            )
            
            // Handle image for new book
            if let newImage = selectedImage,
               let imageData = newImage.jpegData(compressionQuality: 0.8) {
                let uploadedImage = UploadedImage(imageData: imageData)
                modelContext.insert(uploadedImage)
                newBook.coverImage = uploadedImage
            }
            
            modelContext.insert(newBook)
        }
        
        // Save changes
        try? modelContext.save()
    }
}

// Custom star rating editor
struct StarRatingEditView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { star in
                Button {
                    rating = star
                } label: {
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.title2)
                }
                .buttonStyle(.plain)
            }
            
            if rating > 0 {
                Button("Clear") {
                    rating = 0
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .accessibilityLabel("Rating \(rating) out of 5")
    }
}

#Preview("Add Book") {
    AddEditView()
        .modelContainer(for: [PersistentBook.self, UploadedImage.self])
}

#Preview("Edit Book") {
    let sampleBook = PersistentBook(
        title: "Sample Book",
        author: "Sample Author",
        genre: .fiction,
        rating: 4
    )
    
    AddEditView(book: sampleBook)
        .modelContainer(for: [PersistentBook.self, UploadedImage.self])
}
