//
//  UIFont+Extensions.swift
//  Matemagica
//
//  Created by dani on 4/27/22.
//  Copyright © 2022 Dani Springer. All rights reserved.
//

import UIKit


extension UIFont {
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
}
