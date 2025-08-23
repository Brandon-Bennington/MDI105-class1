// Book.swift
import Foundation

struct Book: Identifiable, Codable {
    let id: UUID
    var title: String
    var image: String
    var description: String

    var isFavorite: Bool = false
    var genre: Genre = .fiction
    var status: ReadingStatus = .toRead
    var rating: Int = 0

    init(
        id: UUID = UUID(),
        title: String,
        image: String,
        description: String,
        isFavorite: Bool = false,
        genre: Genre = .fiction,
        status: ReadingStatus = .toRead,
        rating: Int = 0
    ) {
        self.id = id
        self.title = title
        self.image = image
        self.description = description
        self.isFavorite = isFavorite
        self.genre = genre
        self.status = status
        self.rating = rating
    }
}
