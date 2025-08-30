//
//  MDI105_class1App.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 06/08/25.
//

import SwiftUI
import SwiftData

@main
struct MDI105_class1App: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .modelContainer(for: [
                    PersistentBook.self,
                    UploadedImage.self
                ])
        }
    }
}
