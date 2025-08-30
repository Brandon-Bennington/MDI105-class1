//
//  LinkView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

struct LinkView: View {
    let book: PersistentBook

    private var bookImage: UIImage? {
        guard let coverImage = book.coverImage,
              let imageData = coverImage.imageData else {
            return UIImage(systemName: "book")
        }
        return UIImage(data: imageData)
    }

    var body: some View {
        HStack(spacing: 12) {
            // Book cover with heart indicator (visual only)
            ZStack(alignment: .topTrailing) {
                Image(uiImage: bookImage ?? UIImage(systemName: "book")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                // Heart indicator (shows favorite status, not interactive)
                if book.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.pink)
                        .font(.system(size: 12, weight: .semibold))
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                        .offset(x: 2, y: -2)
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(book.title)
                    .font(.subheadline)
                    .lineLimit(1)
                
                Text(book.author)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                Text(book.genre.rawValue)
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            
            Spacer()
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    let sampleBook = PersistentBook(
        title: "Sample Book",
        author: "Sample Author",
        genre: .fiction,
        rating: 4,
        isFavorite: true
    )
    
    LinkView(book: sampleBook)
        .padding()
        .previewLayout(.sizeThatFits)
}

#Preview {
    let sampleBook = PersistentBook(
        title: "Sample Book",
        author: "Sample Author",
        genre: .fiction,
        rating: 4,
        isFavorite: true
    )
    
    LinkView(book: sampleBook)
        .padding()
        .previewLayout(.sizeThatFits)
}
