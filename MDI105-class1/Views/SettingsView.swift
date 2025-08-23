//
//  Untitled.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

enum Theme: String, CaseIterable {
    case light, dark, system
}

struct SettingsView: View {
    
    @AppStorage("theme") private var theme: Theme = .system
    @AppStorage(GRID_COLUMN_NUMBERS_KEY) private var gridColumnNumber: Int = 2
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")) {
                    Picker("Theme", selection: $theme) {
                        ForEach(Theme.allCases, id: \.self) { theme in
                            Text(String(describing: theme))
                        }
                    }
                }
                Section(header: Text("Grid Settings")) {
                    Stepper("Columns: \(gridColumnNumber)", value: $gridColumnNumber, in: 2...4)
                }
            }
        }
    }
}
