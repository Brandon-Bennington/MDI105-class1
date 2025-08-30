//
//  ImageViewer.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 23/08/25.
//

import SwiftUI
import SwiftData

struct ImageViewer: View {
    @Query var allImages: [UploadedImage]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(allImages, id: \.id) { uploadedImage in
                    if let imageData = uploadedImage.imageData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        Image(systemName: "photo")
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("All Images")
        }
    }
}
