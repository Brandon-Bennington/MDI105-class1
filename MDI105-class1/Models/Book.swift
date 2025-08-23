//
//  Book.swift
//  MDI105_class1
//
//  Created by Brandon Bennington on 8/9/25.
//

import Foundation
import SwiftData

public struct Book: Identifiable {
    public let id = UUID()
    var title: String
    var author: String
//    var image: String
    var imageId: PersistentIdentifier?;
    var description: String = ""
    var rating: Int = 0    // 1–5 stars
    var review: String = ""
    var status: ReadingStatus = .planToRead
    var genre: Genre
    var isFavorite: Bool = false
}

@Model
class PersistentBook {
    
    var title: String
    var author: String
    @Attribute(.externalStorage) var imageData: Data?
    
    init(title: String, author: String)
}
