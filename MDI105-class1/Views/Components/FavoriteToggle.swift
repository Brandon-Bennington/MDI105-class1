//
//  FavoriteToggle.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

struct FavoriteToggle: View {
    @Binding var isOn: Bool
    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            Image(systemName: isOn ? "heart.fill" : "heart")
                .symbolEffect(.bounce, value: isOn)
                .foregroundStyle(isOn ? .pink : .secondary)
                .padding(6)
                .background(.ultraThinMaterial, in: Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isOn ? "Unfavorite" : "Favorite")
    }
}
