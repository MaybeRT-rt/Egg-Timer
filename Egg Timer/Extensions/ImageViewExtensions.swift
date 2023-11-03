//
//  ImageViewExtensions.swift
//  Egg Timer
//
//  Created by Liz-Mary on 03.11.2023.
//

import UIKit

extension UIImageView {
    convenience init(imageName: String) {
        self.init()
        self.image = UIImage(named: imageName)
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
    }
}

