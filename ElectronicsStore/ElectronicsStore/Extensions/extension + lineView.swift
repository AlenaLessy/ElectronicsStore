//
//  extension + lineView.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 12.10.2022.
//
import UIKit

/// extension for line
extension UIViewController {
    func makeLineView(yCoordinate: CGFloat, color: UIColor) -> UIView {
        let line = UIView()
        line.backgroundColor = color
        line.frame = CGRect(x: 15, y: yCoordinate, width: view.frame.width - 30, height: 1)
        return line
    }
}

/// extension change of size image
extension UIImage {
    func resizeImage(to size: CGSize) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
