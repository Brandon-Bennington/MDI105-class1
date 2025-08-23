//
//  UploadedImage.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 23/08/25.
//

import SwiftData
import Foundation

@Model
class UploadedImage {
    @Attribute(.externalStorage) var imageData: Data?
    
    init(imageData: Data?) {
        self.imageData = imageData
    }
}
