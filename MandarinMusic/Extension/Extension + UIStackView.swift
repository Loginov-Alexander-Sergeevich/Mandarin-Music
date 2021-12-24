//
//  Extension + UIStackView.swift
//  MandarinMusic
//
//  Created by Александр Александров on 18.12.2021.
//

import Foundation
import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution, aligment: UIStackView.Alignment) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = aligment
    }
}
