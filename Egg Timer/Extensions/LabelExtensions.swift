//
//  LabelExtensions.swift
//  Egg Timer
//
//  Created by Liz-Mary on 03.11.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = .black
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
