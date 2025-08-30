//
//  Book.swift
//  MDI105_class1
//
//  Created by Brandon Bennington on 8/9/25.
//

import Foundation
import SwiftData

@Model
class PersistentBook {
    var title: String
    var author: String
    var bookDescription: String // renamed to avoid conflicts with NSObject.description
    var rating: Int
    var review: String
    var status: ReadingStatus
    var genre: Genre
    var isFavorite: Bool
    
    // Relationship to UploadedImage for cover image
    @Relationship var coverImage: UploadedImage?
    
    init(
        title: String,
        author: String,
        description: String = "",
        genre: Genre = .fiction,
        rating: Int = 0,
        review: String = "",
        status: ReadingStatus = .planToRead,
        isFavorite: Bool = false,
        coverImage: UploadedImage? = nil
    ) {
        self.title = title
        self.author = author
        self.bookDescription = description
        self.rating = rating
        self.review = review
        self.status = status
        self.genre = genre
        self.isFavorite = isFavorite
        self.coverImage = coverImage
    }
}

// MARK: - Convenience computed properties for compatibility
extension PersistentBook {
    // For views that expect 'description' property
    var description: String {
        get { bookDescription }
        set { bookDescription = newValue }
    }
}
