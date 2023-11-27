//
//  UIImageView + Extension.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 25.11.2023.
//

import UIKit

extension UIImageView {
    static func createCustomImageView() -> UIImageView {
        let customIV = UIImageView()
        customIV.isUserInteractionEnabled = true
        customIV.layer.cornerRadius = 10
        customIV.clipsToBounds = true
        return customIV
    }
}

