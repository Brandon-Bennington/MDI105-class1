//
//  StarRatingView.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Int   // 0...5
    let max: Int = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<max, id: \.self) { idx in
                Image(systemName: idx < rating ? "star.fill" : "star")
                    .imageScale(.small)
            }
        }
        .foregroundStyle(.yellow)
        .accessibilityLabel(Text("Rating \(rating) out of \(max)"))
    }
}
