//
//  SquareCardView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

struct SquareCardView: View {
    let book: PersistentBook

    private var bookImage: UIImage? {
        guard let coverImage = book.coverImage,
              let imageData = coverImage.imageData else {
            return nil
        }
        return UIImage(data: imageData)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Book cover image with fixed aspect ratio
            if let bookImage = bookImage {
                Image(uiImage: bookImage)
                    .resizable()
                    .aspectRatio(3/4, contentMode: .fill)
                    .frame(maxHeight: 160)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                // Fallback for books without images
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.2))
                    .aspectRatio(3/4, contentMode: .fit)
                    .frame(maxHeight: 160)
                    .overlay {
                        Image(systemName: "book.closed")
                            .font(.system(size: 30))
                            .foregroundStyle(.secondary)
                    }
            }

            // Book details - fixed spacing
            VStack(alignment: .leading, spacing: 4) {
                // Book title
                Text(book.title)
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(minHeight: 36, alignment: .top)

                // Book author
                Text(book.author)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                // Rating (only show if > 0)
                if book.rating > 0 {
                    HStack(spacing: 2) {
                        ForEach(1...book.rating, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 10))
                        }
                    }
                    .padding(.top, 2)
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        .background(.white, in: RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(book.title) by \(book.author)")
    }
}

#Preview {
    let sampleBook = PersistentBook(
        title: "The Fellowship of the Ring",
        author: "J.R.R. Tolkien",
        description: "A hobbit's journey begins...",
        genre: .fantasy,
        rating: 5,
        status: .finished,
        isFavorite: true
    )
    
    HStack(spacing: 16) {
        SquareCardView(book: sampleBook)
        SquareCardView(book: sampleBook)
    }
    .padding()
    .background(.gray.opacity(0.1))
    .modelContainer(for: [PersistentBook.self, UploadedImage.self])
}

#Preview {
    let sampleBook = PersistentBook(
        title: "The Fellowship of the Ring",
        author: "J.R.R. Tolkien",
        description: "A hobbit's journey begins...",
        genre: .fantasy,
        rating: 5,
        status: .finished,
        isFavorite: true
    )
    
    HStack {
        SquareCardView(book: sampleBook)
        SquareCardView(book: sampleBook)
    }
    .padding()
    .modelContainer(for: [PersistentBook.self, UploadedImage.self])
}

#Preview {
    let sampleBook = PersistentBook(
        title: "The Fellowship of the Ring",
        author: "J.R.R. Tolkien",
        description: "A hobbit's journey begins...",
        genre: .fantasy,
        rating: 5,
        status: .finished,
        isFavorite: true
    )
    
    SquareCardView(book: sampleBook)
        .frame(width: 180)
        .padding()
        .modelContainer(for: [PersistentBook.self, UploadedImage.self])
}

#Preview {
    let sampleBook = PersistentBook(
        title: "The Fellowship of the Ring",
        author: "J.R.R. Tolkien",
        description: "A hobbit's journey begins...",
        genre: .fantasy,
        rating: 5,
        status: .finished,
        isFavorite: true
    )
    
    SquareCardView(book: sampleBook)
        .frame(width: 180)
        .padding()
        .modelContainer(for: [PersistentBook.self, UploadedImage.self])
}
