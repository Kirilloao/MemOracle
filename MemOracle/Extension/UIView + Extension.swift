//
//  UIView + Extension.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 25.11.2023.
//

import UIKit


extension UIView {
    static func makePlugView(with target: Any, and selector: Selector) -> UIView {
        let customPlug = QuestionView()
        let gestureRecognizer = UITapGestureRecognizer(target: target, action: selector)
        customPlug.addGestureRecognizer(gestureRecognizer)
        return customPlug
    }
    
    static func makeViewForButton(with color: UIColor) -> UIView {
        let newMemView = UIView()
        newMemView.layer.borderColor = color.cgColor
        newMemView.layer.borderWidth = 2
        newMemView.layer.cornerRadius = 30
        newMemView.layer.shadowColor = UIColor.darkGray.cgColor
        newMemView.layer.shadowOpacity = 0.5 // Прозрачность тени
        newMemView.layer.shadowOffset = CGSize(width: 0, height: 3) // Смещение тени относительно view
        newMemView.layer.shadowRadius = 3 // Радиус размытия тени
        return newMemView
    }
}
