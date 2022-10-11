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
        static let imageGrayCaseNames = ["Image", "case2", "case3"]
        static let imageStrapNames = ["4", "3", "clock2"]
        static let imageGoldCaseNames = ["2", "caseBrown2", "caseBrown3"]
        static let grayCaseText = "Чехол Incase Flat для MacBook Pro 16 дюймов"
        static let strapText = "Спортивный ремешок Black Unity (для к..."
        static let goldCaseText = "Кожанный чехол для MacBook Pro 16 дюймов золотой"
        static let productPrice =  "3 990.00 руб."
    }
    
    // MARK: - Private Visual Components
  
    private lazy var queryOptionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.frame = CGRect(x: 10, y: 480, width: 300, height: 40)
        label.text = Constants.queryOptionsText
        label.textColor = .white
        return label
    }()
    
    private lazy var searchLabel: UILabel = {
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
        scroll.contentSize = CGSize(width: 421, height: 180)
        return scroll
    }()
    
    // MARK: - Private Properties
    
    private var productInfo = [
        ProductInfo(productName: Constants.grayCaseText,
                    productImageNames: Constants.imageGrayCaseNames,
                    productPrice: Constants.productPrice),
        ProductInfo(productName: Constants.strapText,
                    productImageNames: Constants.imageStrapNames,
                    productPrice: Constants.productPrice),
        ProductInfo(productName: Constants.goldCaseText,
                    productImageNames: Constants.imageGoldCaseNames,
                    productPrice: Constants.productPrice)
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
            let line = makeLineView(yCoordinate: yCoordinate)
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
    
    private func makeLineView(yCoordinate: CGFloat) -> UIView {
        let line = UIView()
        line.backgroundColor = .systemGray6
        line.frame = CGRect(x: 15, y: yCoordinate, width: view.frame.width - 30, height: 1)
        return line
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
        image.frame = CGRect(x: xCoordinate, y: 20, width: 105, height: 90)
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
