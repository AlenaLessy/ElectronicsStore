//
//  ProductViewController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 06.10.2022.
//

import UIKit
/// Экран продукта
final class ProductViewController: UIViewController {
 // MARK: - Publick Properties
var productImage = ""
    var productName = ""
    
    // MARK: - Private Visual Components
    private lazy var productImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 100, y: 300, width: 250, height: 200)
        image.image = UIImage(named: productImage)
        return image
    }()
    
    private lazy var productLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.frame = CGRect(x: productImageView.frame.minX,
                             y: productImageView.frame.maxY + 10,
                             width: 200,
                             height: 60)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = productName
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubview()
        
    }
    // MARK: - Private Methods
    private func addSubview() {
        view.addSubview(productImageView)
        view.addSubview(productLabel)
    }

}
