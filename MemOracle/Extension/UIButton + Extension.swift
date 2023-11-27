//
//  UIButton + Extension.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 25.11.2023.
//

import UIKit

extension UIButton {
    static func makeCustomButton(with image: UIImage, and color: UIColor) -> UIButton {
        let customButton = UIButton(type: .system)
        customButton.setImage(image, for: .normal)
        customButton.tintColor = color
        return customButton
    }
}
