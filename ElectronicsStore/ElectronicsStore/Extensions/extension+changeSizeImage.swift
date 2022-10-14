//
//  extension+changeSizeImage.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 13.10.2022.
//

import UIKit

/// extension change of size image
extension UIImage {
    func resizeImage(to size: CGSize) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
