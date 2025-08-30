//
//  Genre.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

enum Genre: String, CaseIterable, Codable {
    case fiction = "Fiction"
    case nonFiction = "Non-Fiction"
    case sciFi = "Sci-Fi"
    case fantasy = "Fantasy"
    case mystery = "Mystery"
    case biography = "Biography"
    case classic = "Classic"
}
