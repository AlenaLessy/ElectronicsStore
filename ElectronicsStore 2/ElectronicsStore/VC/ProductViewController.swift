//
//  ProductViewController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 06.10.2022.
//

import UIKit
/// Экран продукта
final class ProductViewController: UIViewController {
    
    private enum Constant {
        static let systemImageHeart = "heart"
        static let systemImageCheckmark = "checkmark.circle.fill"
        static let systemImageSquare = "square.and.arrow.up"
        static let systemImageShippingBox = "shippingbox"
        static let todayOrderText = "Заказ сегодня, в течение дня доставка:"
        static let dateOrderText = "Чт 25 Фев - Бесплатно"
        static let locationOrderText = "Варианты доставки для местоположения: 115533"
        static let compatibleText = "Совместимо с"
        static let macBookText = "MacBook Pro - Евгений"
    }
    
    // MARK: - Publick Properties
    var productInfo = ProductInfo()
    
    // MARK: - Private Visual Components
    
    private lazy var todayOrderLabel = makeLabel(xCoordinate: 40,
                                                 yCoordinate: 695,
                                                 text: Constant.todayOrderText,
                                                 textColor: .white,
                                                 font: UIFont.systemFont(ofSize: 12, weight: .bold))
    
    private lazy var compatibleLabel = makeLabel(xCoordinate: 85,
                                                 yCoordinate: 575,
                                                 text: Constant.compatibleText,
                                                 textColor: .gray,
                                                 font: UIFont.systemFont(ofSize: 12))
    
    private lazy var macBookLabel = makeLabel(xCoordinate: 175,
                                              yCoordinate: 575,
                                              text: Constant.macBookText,
                                              textColor: .systemBlue,
                                              font: UIFont.systemFont(ofSize: 12))
    
    private lazy var dateOrderLabel = makeLabel(xCoordinate: 40,
                                                yCoordinate: 712,
                                                text: Constant.dateOrderText,
                                                textColor: .gray,
                                                font: UIFont.systemFont(ofSize: 12))
    
    private lazy var locationOrderLabel = makeLabel(xCoordinate: 40,
                                                    yCoordinate: 727,
                                                    text: Constant.locationOrderText,
                                                    textColor: .systemBlue,
                                                    font: UIFont.systemFont(ofSize: 12))
    
    private lazy var whiteColorButton = makeButton(color: .lightGray, xCoordinate: 150)
    private lazy var grayColorButton = makeButton(color: .systemGray4, xCoordinate: 205)
    private lazy var whiteColorButtonView = makeButtonView(xCoordinate: 149)
    private lazy var grayColorButtonView = makeButtonView(xCoordinate: 204)
    
    private lazy var productImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 80, y: 10, width: 250, height: 170)
        guard let imageName = productInfo.productImageNames.first else { return image }
        image.image = UIImage(named: imageName)
        return image
    }()
    
    private lazy var compatibleImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 60, y: 580, width: 20, height: 20)
        image.image = UIImage(systemName: Constant.systemImageCheckmark)
        image.tintColor = .green
        return image
    }()
    
    private lazy var boxImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 10, y: 700, width: 20, height: 20)
        image.image = UIImage(systemName: Constant.systemImageShippingBox)
        image.tintColor = .gray
        return image
    }()
    
    private lazy var productTwoImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 480, y: 10, width: 250, height: 170)
        guard productInfo.productImageNames.count > 2 else { return image }
        image.image = UIImage(named: productInfo.productImageNames[1])
        return image
    }()
    
    private lazy var productThreeImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 880, y: 10, width: 250, height: 170)
        guard let imageName = productInfo.productImageNames.last else { return image }
        image.image = UIImage(named: imageName)
        return image
    }()
    
    private lazy var productLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.frame = CGRect(x: 0,
                             y: 100,
                             width: view.frame.width,
                             height: 60)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = productInfo.productName
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var productGrayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.frame = CGRect(x: 0,
                             y: 420,
                             width: view.frame.width,
                             height: 60)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = productInfo.productName
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.frame = CGRect(x: 0,
                             y: 125,
                             width: view.frame.width,
                             height: 60)
        label.textAlignment = .center
        label.text = productInfo.productPrice
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var addProduct: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 10, y: 630, width: view.frame.width - 10, height: 40)
        btn.backgroundColor = #colorLiteral(red: 0.05358404666, green: 0.5216525197, blue: 1, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Добавить в корзину", for: .normal)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    private lazy var productScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.delegate = self
        scroll.frame = .init(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 230)
        scroll.contentSize = CGSize(width: view.bounds.size.width * 3, height: 180)
        scroll.indicatorStyle = .black
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    private lazy var backgroundForIndicator: UIView = {
        let view = UIView()
        view.alpha = 0
        view.frame = .init(x: 0, y: 425, width: UIScreen.main.bounds.width, height: 1.5)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var barButtonItems = {
        let heartBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constant.systemImageHeart))
        let squreBarButtonItem2 = UIBarButtonItem(image: UIImage(systemName: Constant.systemImageSquare))
        return [heartBarButtonItem, squreBarButtonItem2]
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubview()
        configureButton()
        setupBarButtonItems()
        
    }
    
    // MARK: - Private Action
    
    @objc private func whiteButtonAction(_ sender: UIButton) {
        whiteColorButtonView.isHidden = false
        grayColorButtonView.isHidden = true
    }
    
    @objc private func grayButtonAction(_ sender: UIButton) {
        whiteColorButtonView.isHidden = true
        grayColorButtonView.isHidden = false
    }
    
    // MARK: - Private Methods
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItems = barButtonItems
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    private func addSubview() {
        view.addSubview(productLabel)
        view.addSubview(priceLabel)
        view.addSubview(productScrollView)
        view.addSubview(productGrayLabel)
        view.addSubview(backgroundForIndicator)
        productScrollView.addSubview(productImageView)
        productScrollView.addSubview(productTwoImageView)
        productScrollView.addSubview(productThreeImageView)
        view.bringSubviewToFront(productScrollView)
        view.addSubview(whiteColorButtonView)
        view.addSubview(grayColorButtonView)
        view.addSubview(whiteColorButton)
        view.addSubview(grayColorButton)
        view.addSubview(boxImageView)
        view.addSubview(todayOrderLabel)
        view.addSubview(dateOrderLabel)
        view.addSubview(locationOrderLabel)
        view.addSubview(addProduct)
        view.addSubview(compatibleImageView)
        view.addSubview(compatibleLabel)
        view.addSubview(macBookLabel)
    }
    
    private func makeButton(color: UIColor, xCoordinate: CGFloat) -> UIButton {
        let btn = UIButton()
        btn.frame = CGRect(x: xCoordinate, y: 505, width: 38, height: 38)
        btn.layer.cornerRadius = 19
        btn.backgroundColor = color
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }
    
    private func configureButton() {
        whiteColorButton.addTarget(self, action: #selector(whiteButtonAction), for: .touchUpInside)
        grayColorButton.addTarget(self, action: #selector(grayButtonAction), for: .touchUpInside)
    }
    
    private func makeButtonView(xCoordinate: CGFloat) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: xCoordinate, y: 504, width: 40, height: 40)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 20
        view.isHidden = true
        return view
    }
    
    private func makeLabel(xCoordinate: CGFloat,
                           yCoordinate: CGFloat,
                           text: String,
                           textColor: UIColor,
                           font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 300, height: 30)
        label.textAlignment = .left
        return label
    }
}

/// UIScrollViewDelegate
extension ProductViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // метод UIView для которого нужна анимация определенной длительности
        UIView.animate(withDuration: 0.32) {
            self.backgroundForIndicator.alpha = 1
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.33) {
            self.backgroundForIndicator.alpha = 0
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}
