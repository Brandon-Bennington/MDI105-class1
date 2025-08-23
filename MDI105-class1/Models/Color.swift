//  Color+RawRepresentable.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 20/08/25.
//

import SwiftUI
import UIKit

extension Color: RawRepresentable {
    public init?(rawValue: String) {
        // Decode Base64 → Data → UIColor
        guard
            let data = Data(base64Encoded: rawValue),
            let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
        else {
            return nil
        }
        self = Color(uiColor)
    }

    public var rawValue: String {
        let uiColor = UIColor(self)  // ← non-optional
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: uiColor,
                                                           requiringSecureCoding: false)
        else {
            return ""
        }
        return data.base64EncodedString()
    }
}
