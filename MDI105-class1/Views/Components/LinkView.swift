//
//  LinkView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

struct LinkView: View {
    let book: Book
    var bookImage: UIImage? {
        guard let imageId = book.imageId,
              let imageModel = modelContext.model(for: imageId) as? UploadedImage,
                let imageData = imageModel.imageData as Data? else {
            return UIImage(systemName: "book")
        }
        return UIImage(data: imageData)
        
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(book.image)
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 2) {
                Text(book.title).font(.subheadline)
                Text(book.genre.rawValue)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

