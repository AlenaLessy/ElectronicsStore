//
//  ThreeViewController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 06.10.2022.
//

import UIKit

/// Экран поиска
final class SearchViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let searchImageName = "magnifyingglass"
        static let searchLabelText = "Поиск"
        static let placeholderText = " Поиск по продуктам и магазинам"
        static let recentlyWatchedText = "Недавно просмотренные"
        static let clearButtonText = "Очистить"
        static let requestOptionText = ["AirPods", "ApleCare", "Beats", "Сравните модели IPhone"]
        static let queryOptionsText = "Варианты запросов"
        static let imageClassicStrapNames = ["1", "2", "3"]
        static let classicStrapText = "Ремешок Native Union Classic Strap для Apple Watch 42/44/45мм, силикон, черный"
        static let imagePouchEnvelopeNames = ["4", "5", "6"]
        static let pouchEnvelopeCaseText = "Чехол-конверт DBramante1928 MODE Paris для MacBook Pro 16, кожа, бежевый"
        static let imageMagicMouseNames = ["7", "8", "9"]
        static let magicMouseText = "Мышь Apple Magic Mouse, черный"
        static let imageHeadphonesNames = ["10", "11", "12"]
        static let headphonesText = "Беспроводные наушники Sudio E2, серый"
        static let productPrice =  ["8 390.00 руб.", "4 990.00 руб.", "14 990.00 руб.", "8 990.00 руб."]
        static let classicStrapPageAdress = "https://re-store.ru/catalog/CSTRAP-AW-L-BLK/"
        static let pouchEnvelopeCasePageAdress = "https://re-store.ru/catalog/PA15SASA5450/"
        static let magicMousePageAdress = "https://re-store.ru/catalog/MMMQ3/"
        static let headphonesPageAdress = "https://re-store.ru/catalog/E2GRY/"
    }
    
    // MARK: - Private Visual Components
  
    private var queryOptionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.frame = CGRect(x: 10, y: 480, width: 300, height: 40)
        label.text = Constants.queryOptionsText
        label.textColor = .white
        return label
    }()
    
    private var searchLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.frame = CGRect(x: 10, y: 100, width: 100, height: 40)
        label.text = Constants.searchLabelText
        label.textColor = .white
        return label
    }()
    
    private lazy var productsSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Constants.placeholderText
        searchBar.frame = CGRect(x: 0, y: searchLabel.frame.maxY + 10, width: view.frame.width, height: 35)
        return searchBar
    }()
    
    private lazy var recentlyWatchedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.frame = CGRect(x: searchLabel.frame.minX, y: searchLabel.frame.maxY + 80, width: 300, height: 40)
        label.text = Constants.recentlyWatchedText
        label.textColor = .white
        return label
    }()
    
    private lazy var clearButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.setTitle(Constants.clearButtonText, for: .normal)
        btn.frame = CGRect(x: recentlyWatchedLabel.frame.maxY + 25,
                           y: recentlyWatchedLabel.frame.minY + 6,
                           width: 100,
                           height: 30)
        return btn
    }()
    
    private lazy var productScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.frame = .init(x: 0, y: 270, width: UIScreen.main.bounds.width, height: 180)
        scroll.contentSize = CGSize(width: 600, height: 180)
        return scroll
    }()
    
    // MARK: - Private Properties
    
    private var productInfo = [
        ProductInfo(productName: Constants.classicStrapText,
                    productImageNames: Constants.imageClassicStrapNames,
                    productPrice: Constants.productPrice[0], pageAdress: Constants.classicStrapPageAdress),
        ProductInfo(productName: Constants.pouchEnvelopeCaseText,
                    productImageNames: Constants.imagePouchEnvelopeNames,
                    productPrice: Constants.productPrice[1], pageAdress: Constants.pouchEnvelopeCasePageAdress),
        ProductInfo(productName: Constants.magicMouseText,
                    productImageNames: Constants.imageMagicMouseNames,
                    productPrice: Constants.productPrice[2], pageAdress: Constants.magicMousePageAdress),
        ProductInfo(productName: Constants.headphonesText,
                    productImageNames: Constants.imageHeadphonesNames,
                    productPrice: Constants.productPrice[3], pageAdress: Constants.headphonesPageAdress)
    ]
        
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubview()
        addProduct()
        addLine()
        addRequest()
    }
    
    // MARK: - Private Action
    
    @objc private func recognaizerAction(_ sender: UIGestureRecognizer) {
        let productViewController = ProductViewController()
        guard let currentIndex = sender.view?.tag,
              currentIndex < productInfo.count
        else { return }
        productViewController.productInfo = productInfo[currentIndex]
        navigationController?.pushViewController(productViewController, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func addRequest() {
   var yCoordinate: CGFloat = 535
        for value in Constants.requestOptionText {
            let label = makeQueryOptionsLabel(text: value, yCoordinate: yCoordinate)
            let imageView = makeQueryOptionsImageView(yCoordinate: yCoordinate)
            yCoordinate += 45
            view.addSubview(label)
            view.addSubview(imageView)
        }
    }
    
   private func addProduct() {
        var xCoordinateBavkgroundView: CGFloat = 10
        for (index, value) in productInfo.enumerated() {
            let backgroundView = makeProductView(xCoordinate: xCoordinateBavkgroundView, tag: index)
            xCoordinateBavkgroundView += 143
            view.addSubview(backgroundView)
            guard let imageName = value.productImageNames.first else { return }
            let imageView = makeImageView(xCoordinate: 20, name: imageName)
            backgroundView.addSubview(imageView)
            let productLabel = makeProductLabel(text: value.productName, xCoordinate: 15)
            backgroundView.addSubview(productLabel)
            productScrollView.addSubview(backgroundView)
        }
    }
    
    private func addLine() {
        var yCoordinate: CGFloat = 565
        for _ in 0...3 {
            let line = makeLineView(yCoordinate: yCoordinate, color: .systemGray6)
            yCoordinate += 45
            view.addSubview(line)
        }
    }
    
    private func addRecognaizer(view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recognaizerAction))
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    private func addSubview() {
        let labels = [searchLabel, recentlyWatchedLabel, queryOptionsLabel]
        labels.forEach { view.addSubview($0) }
        
        view.addSubview(clearButton)
        view.addSubview(productsSearchBar)
        view.addSubview(productScrollView)
    }
    
    private func makeQueryOptionsImageView(yCoordinate: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.searchImageName)
        imageView.tintColor = .systemGray
        imageView.frame = CGRect(x: 5, y: yCoordinate, width: 15, height: 15)
        return imageView
    }
    
    private func makeQueryOptionsLabel(text: String, yCoordinate: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.tintColor = .white
        label.font = UIFont.systemFont(ofSize: 19)
        label.frame = CGRect(x: 30, y: yCoordinate - 7, width: 250, height: 30)
        return label
    }
 
    private func makeProductView(xCoordinate: CGFloat, tag: Int) -> UIView {
        let view = UIView()
        view.tag = tag
        view.frame = CGRect(x: xCoordinate, y: 0, width: 135, height: 180)
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemGray6
        addRecognaizer(view: view)
        return view
    }
    
    private func makeImageView(xCoordinate: CGFloat, name: String) -> UIImageView {
        let image = UIImageView()
        image.frame = CGRect(x: xCoordinate, y: 20, width: 90, height: 90)
        image.image = UIImage(named: name)
        return image
    }
    
    private func makeProductLabel(text: String, xCoordinate: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.tintColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.frame = CGRect(x: xCoordinate, y: 100, width: 110, height: 70)
        label.numberOfLines = 3
        return label
    }
}
