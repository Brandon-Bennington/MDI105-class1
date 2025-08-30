//
//  ImageField.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 23/08/25.
//

import SwiftUI
import PhotosUI

struct ImageField: View {
    @Binding var image: UIImage?
    @State private var photoPickerItem: PhotosPickerItem?

    var body: some View {
        PhotosPicker(
            selection: $photoPickerItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            if let image = image {
                Image(uiImage: image)
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
                    self.image = uiImage
                }
            }
        }
    }
}
