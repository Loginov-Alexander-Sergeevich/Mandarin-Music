//
//  Extension + UIView.swift
//  MandarinMusic
//
//  Created by Александр Александров on 18.12.2021.
//

import Foundation
import UIKit

extension UIView {
    func addSabviews(views: [UIView]) {
        for item in views {
            addSubview(item)
        }
    }
}
