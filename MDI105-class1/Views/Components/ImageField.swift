//
//  ImageField.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 23/08/25.
//

import SwiftUI
import PhotosUI

public struct ImageField: View {
    @Binding var image: UIImage?
    @State private var photoPickerItem: PhotosPickerItem?

    public var body: some View {
        PhotosPicker(
            selection: $photoPickerItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            Image(uiImage: image ?? UIImage(resource: .defaultBook))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
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
