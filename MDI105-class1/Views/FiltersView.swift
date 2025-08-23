//
//  FiltersView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

struct FiltersView: View {
    @Binding var selectedGenre: Genre?
    @Binding var selectedStatus: ReadingStatus?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Genre") {
                    Picker("Genre", selection: $selectedGenre) {
                        Text("All").tag(Genre?.none)
                        ForEach(Genre.allCases, id: \.self) { g in
                            Text(g.rawValue).tag(Optional(g))
                        }
                    }
                }
                Section("Reading Status") {
                    Picker("Status", selection: $selectedStatus) {
                        Text("All").tag(ReadingStatus?.none)
                        ForEach(ReadingStatus.allCases, id: \.self) { s in
                            Text(s.rawValue).tag(Optional(s))
                        }
                    }
                }
                if selectedGenre != nil || selectedStatus != nil {
                    Button("Clear Filters", role: .destructive) {
                        selectedGenre = nil
                        selectedStatus = nil
                    }
                }
            }
            .navigationTitle("Filters")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") { dismiss() }
                }
            }
        }
    }
}
