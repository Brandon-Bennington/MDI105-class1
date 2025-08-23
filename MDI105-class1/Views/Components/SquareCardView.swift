//
//  SquareCardView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

struct SquareCardView: View {
    let book: Book

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Image(book.image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(3/4, contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                // dummy favorite (read-only because Book currently doesn’t store it)
                Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                    .padding(8)
                    .foregroundStyle(book.isFavorite ? .pink : .secondary)
            }

            Text(book.title)
                .font(.headline)
                .lineLimit(2)

            HStack(spacing: 6) {
                CustomCapsule(text: book.genre.rawValue)
                CustomCapsule(text: book.status.rawValue)
            }

            StarRatingView(rating: book.rating)
        }
    }
}
