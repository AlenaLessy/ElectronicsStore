//
//  ThreeViewController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 06.10.2022.
//

import UIKit
/// Экран поиска
class SearchViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let tabBarImageName = "magnifyingglass"
        static let tabBarTitle = "Поиск"
        static let placeholderText = " Поиск по продуктам и магазинам"
        static let recentlyWatchedText = "Недавно просмотренные"
        static let clearButtonText = "Очистить"
        static let requestOptionOneText = "AirPods"
        static let requestOptionTwoText = "ApleCare"
        static let requestOptionThreeText = "Beats"
        static let requestOptionFourText = "Сравните модели IPhone"
        static let queryOptionsText = "Варианты запросов"
        static let imageGrayCaseName = "Image"
        static let imageStrapName = "4"
        static let imageGoldCaseName = "2"
        static let grayCaseText = "Чехол Incase Flat для MacBook pro 16 дюймов"
        static let strapText = "Спортивный ремешок Black Unity (для к..."
        static let goldCaseText = "Кожанный чехол для MacBook pro 16 дюймов золотой"
        
    }
    
    // MARK: - Private Visual Components
    private lazy var requestOptionOneLabel = makeQueryOptionsLabel(text: Constants.requestOptionOneText,
                                                                   yCoordinate: 535)
    private lazy var requestOptionOneImageView = makeQueryOptionsImageView(yCoordinate: 535)
    private lazy var lineOne = makeLine(yCoordinate: 565)
    private lazy var requestOptionTwoLabel = makeQueryOptionsLabel(text: Constants.requestOptionTwoText,
                                                                   yCoordinate: 580)
    private lazy var requestOptionTwoImageView = makeQueryOptionsImageView(yCoordinate: 580)
    private lazy var lineTwo = makeLine(yCoordinate: 610)
    private lazy var requestOptionThreeLabel = makeQueryOptionsLabel(text: Constants.requestOptionThreeText,
                                                                   yCoordinate: 625)
    private lazy var requestOptionThreeImageView = makeQueryOptionsImageView(yCoordinate: 625)
    private lazy var lineThree = makeLine(yCoordinate: 655)
    private lazy var requestOptionFourLabel = makeQueryOptionsLabel(text: Constants.requestOptionFourText,
                                                                   yCoordinate: 670)
    private lazy var requestOptionFourImageView = makeQueryOptionsImageView(yCoordinate: 670)
    private lazy var lineFour = makeLine(yCoordinate: 700)
    private lazy var viewOne = makeView(xCoordinate: 10)
    private lazy var viewTwo = makeView(xCoordinate: 153)
    private lazy var viewThree = makeView(xCoordinate: 296)
    private lazy var grayCaseLabel = makeProductLabel(text: Constants.grayCaseText,
                                                      xCoordinate: viewOne.frame.minX + 15)
    private lazy var strapLabel = makeProductLabel(text: Constants.strapText,
                                                      xCoordinate: viewTwo.frame.minX + 15)
    private lazy var goldCaseLabel = makeProductLabel(text: Constants.goldCaseText,
                                                      xCoordinate: viewThree.frame.minX + 15)
   
    private lazy var caseImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: viewOne.frame.minX + 15, y: 300, width: 105, height: 70)
        image.image = UIImage(named: Constants.imageGrayCaseName)
        return image
    }()
    
    private lazy var strapImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: viewTwo.frame.minX + 30, y: 300, width: 70, height: 80)
        image.image = UIImage(named: Constants.imageStrapName)
        return image
    }()
    
    private lazy var caseGoldImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: viewThree.frame.minX + 15, y: 280, width: 105, height: 110)
        image.image = UIImage(named: Constants.imageGoldCaseName)
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
        label.text = Constants.tabBarTitle
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
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBarItemConfigure()
        addSubview()
        addRecognaizer()
    }
    // MARK: - Public Methods
    
    // MARK: - Private Action
    
    @objc private func recognaizerAction(_ sender: UIGestureRecognizer) {
        let productViewController = ProductViewController()
        switch sender.view?.tag {
        case 0:
            productViewController.productName = Constants.grayCaseText
            productViewController.productImage = Constants.imageGrayCaseName
            navigationController?.pushViewController(productViewController, animated: true)
        case 1:
            productViewController.productName = Constants.strapText
            productViewController.productImage = Constants.imageStrapName
            navigationController?.pushViewController(productViewController, animated: true)
        case 2:
            productViewController.productName = Constants.goldCaseText
            productViewController.productImage = Constants.imageGoldCaseName
            navigationController?.pushViewController(productViewController, animated: true)
        default:
            break
        }
    }
    
    // MARK: - Private Methods
    
    private func addRecognaizer() {
        viewOne.tag = 0
        viewOne.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(recognaizerAction)))
        viewOne.isUserInteractionEnabled = true
        viewTwo.tag = 1
        viewTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(recognaizerAction)))
        viewTwo.isUserInteractionEnabled = true
        viewThree.tag = 2
        viewThree.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(recognaizerAction)))
        viewThree.isUserInteractionEnabled = true
    }
    
    private func tabBarItemConfigure() {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(systemName: Constants.tabBarImageName)
        tabBarItem.title = Constants.tabBarTitle
        self.tabBarItem = tabBarItem
    }
    
    private func addSubview() {
        view.addSubview(searchLabel)
        view.addSubview(recentlyWatchedLabel)
        view.addSubview(clearButton)
        view.addSubview(productsSearchBar)
        view.addSubview(requestOptionOneLabel)
        view.addSubview(requestOptionOneImageView)
        view.addSubview(requestOptionTwoImageView)
        view.addSubview(requestOptionTwoLabel)
        view.addSubview(requestOptionThreeImageView)
        view.addSubview(requestOptionThreeLabel)
        view.addSubview(requestOptionFourImageView)
        view.addSubview(requestOptionFourLabel)
        view.addSubview(lineOne)
        view.addSubview(lineTwo)
        view.addSubview(lineThree)
        view.addSubview(lineFour)
        view.addSubview(queryOptionsLabel)
        view.addSubview(viewOne)
        view.addSubview(viewTwo)
        view.addSubview(viewThree)
        view.addSubview(caseImageView)
        view.addSubview(strapImageView)
        view.addSubview(caseGoldImageView)
        view.addSubview(grayCaseLabel)
        view.addSubview(strapLabel)
        view.addSubview(goldCaseLabel)
    }
    
    private func makeQueryOptionsImageView(yCoordinate: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.tabBarImageName)
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
    
    private func makeLine(yCoordinate: CGFloat) -> UIView {
        let line = UIView()
        line.backgroundColor = .systemGray6
        line.frame = CGRect(x: 15, y: yCoordinate, width: view.frame.width - 30, height: 1)
        return line
    }
    
    private func makeView(xCoordinate: CGFloat) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: xCoordinate, y: 270, width: 135, height: 180)
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemGray6
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
        label.frame = CGRect(x: xCoordinate, y: 380, width: 110, height: 70)
        label.numberOfLines = 3
        return label
    }
}
