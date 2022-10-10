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
        static let requestOptionOneText = "AirPods"
        static let requestOptionTwoText = "ApleCare"
        static let requestOptionThreeText = "Beats"
        static let requestOptionFourText = "Сравните модели IPhone"
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
    private lazy var requestOptionOneLabel = makeQueryOptionsLabel(text: Constants.requestOptionOneText,
                                                                   yCoordinate: 535)
    private lazy var requestOptionOneImageView = makeQueryOptionsImageView(yCoordinate: 535)
    private lazy var lineOne = makeLineView(yCoordinate: 565)
    private lazy var requestOptionTwoLabel = makeQueryOptionsLabel(text: Constants.requestOptionTwoText,
                                                                   yCoordinate: 580)
    private lazy var requestOptionTwoImageView = makeQueryOptionsImageView(yCoordinate: 580)
    private lazy var lineTwo = makeLineView(yCoordinate: 610)
    private lazy var requestOptionThreeLabel = makeQueryOptionsLabel(text: Constants.requestOptionThreeText,
                                                                     yCoordinate: 625)
    private lazy var requestOptionThreeImageView = makeQueryOptionsImageView(yCoordinate: 625)
    private lazy var lineThree = makeLineView(yCoordinate: 655)
    private lazy var requestOptionFourLabel = makeQueryOptionsLabel(text: Constants.requestOptionFourText,
                                                                    yCoordinate: 670)
    private lazy var requestOptionFourImageView = makeQueryOptionsImageView(yCoordinate: 670)
    private lazy var lineFour = makeLineView(yCoordinate: 700)
    private lazy var viewOne = makeProductView(xCoordinate: 10, tag: 0)
    private lazy var viewTwo = makeProductView(xCoordinate: 153, tag: 1)
    private lazy var viewThree = makeProductView(xCoordinate: 296, tag: 2)
    private lazy var grayCaseLabel = makeProductLabel(text: Constants.grayCaseText,
                                                      xCoordinate: 15)
    private lazy var strapLabel = makeProductLabel(text: Constants.strapText,
                                                   xCoordinate: 15)
    private lazy var goldCaseLabel = makeProductLabel(text: Constants.goldCaseText,
                                                      xCoordinate: 15)
    
    private lazy var caseImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 15, y: 20, width: 105, height: 70)
        guard Constants.imageGrayCaseNames.count > 0 else { return image }
        image.image = UIImage(named: Constants.imageGrayCaseNames[0])
        return image
    }()
    
    private lazy var strapImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 30, y: 20, width: 70, height: 80)
        guard Constants.imageGrayCaseNames.count > 0 else { return image }
        image.image = UIImage(named: Constants.imageStrapNames[0])
        return image
    }()

    private lazy var caseGoldImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 15, y: 0, width: 105, height: 110)
        guard Constants.imageGrayCaseNames.count > 0 else { return image }
        image.image = UIImage(named: Constants.imageGoldCaseNames[0])
        return image
    }()
    
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
        scroll.contentSize = CGSize(width: viewThree.frame.maxX - viewOne.frame.minX, height: viewOne.frame.height)
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
    
    private func addRecognaizer(view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recognaizerAction))
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    private func addSubview() {
        let labels = [searchLabel, recentlyWatchedLabel, requestOptionOneLabel,
                      requestOptionTwoLabel, requestOptionThreeLabel, requestOptionFourLabel, queryOptionsLabel]
        labels.forEach { view.addSubview($0) }
        
        view.addSubview(clearButton)
        view.addSubview(productsSearchBar)
        view.addSubview(requestOptionOneImageView)
        view.addSubview(requestOptionTwoImageView)
        view.addSubview(requestOptionThreeImageView)
        view.addSubview(requestOptionFourImageView)
        view.addSubview(lineOne)
        view.addSubview(lineTwo)
        view.addSubview(lineThree)
        view.addSubview(lineFour)
        
        view.addSubview(viewOne)
        view.addSubview(viewTwo)
        view.addSubview(viewThree)
        view.addSubview(productScrollView)
        productScrollView.addSubview(viewOne)
        productScrollView.addSubview(viewTwo)
        productScrollView.addSubview(viewThree)
        viewOne.addSubview(caseImageView)
        viewTwo.addSubview(strapImageView)
        viewThree.addSubview(caseGoldImageView)
        viewOne.addSubview(grayCaseLabel)
        viewTwo.addSubview(strapLabel)
        viewThree.addSubview(goldCaseLabel)
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
        image.frame = CGRect(x: xCoordinate, y: 300, width: 105, height: 90)
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
