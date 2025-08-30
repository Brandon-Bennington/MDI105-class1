//
//  constants.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftData

let GRID_COLUMN_NUMBERS_KEY = "gridColumnNumbers"

let SETTINGS_THEME_KEY = "theme"

let SETTINGS_GRID_SHOW_AUTHOR_KEY = "gridShowAuthor"

let SETTINGS_APP_ACCENT_COLOR_KEY = "appAccentColor"

// Factory function to create a new empty book
func createNewBook(context: ModelContext) -> PersistentBook {
    let newBook = PersistentBook(
        title: "",
        author: "",
        description: "",
        genre: .fiction
    )
    context.insert(newBook)
    return newBook
}
