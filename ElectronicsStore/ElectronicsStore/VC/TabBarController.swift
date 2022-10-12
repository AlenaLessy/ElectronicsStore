//
//  TabBarController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 07.10.2022.
//

import UIKit

// Экран таббара
final class MainTabBarController: UITabBarController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let buyTabBarImageName = "laptopcomputer.and.iphone"
        static let buyTabBarTitle = "Купить"
        static let forYouTabBarImageName = "person.circle"
        static let forYouTabBarTitle = "Для вас"
        static let searchTabBarImageName = "magnifyingglass"
        static let searchTabBarTitle = "Поиск"
        static let productTabBarImageName = "bag"
        static let productTabBarTitle = "Корзина"
    }
    
    // MARK: - Private properties
    private lazy var buyViewController: BuyViewController = {
        let viewController = BuyViewController()
        viewController.tabBarItem = UITabBarItem(title: Constants.buyTabBarTitle,
                                                 image: UIImage(systemName: Constants.buyTabBarImageName), tag: 0)
        return viewController
    }()
    
    private lazy var forYouViewController: ForYouViewController = {
        let viewController = ForYouViewController()
        viewController.tabBarItem = UITabBarItem(title: Constants.forYouTabBarTitle,
                                                 image: UIImage(systemName: Constants.forYouTabBarImageName), tag: 1)
        return viewController
    }()
    
    private lazy var searchViewController: SearchViewController = {
        let viewController = SearchViewController()
        viewController.tabBarItem = UITabBarItem(title: Constants.searchTabBarTitle,
                                                 image: UIImage(systemName: Constants.searchTabBarImageName), tag: 2)
        return viewController
    }()
    
    private lazy var shoppingCartController: ShoppingCartViewController = {
        let viewController = ShoppingCartViewController()
        viewController.tabBarItem = UITabBarItem(title: Constants.productTabBarTitle,
                                                 image: UIImage(systemName: Constants.productTabBarImageName), tag: 3)
        return viewController
    }()
    
    private lazy var searchNavigationController = UINavigationController(rootViewController: searchViewController)
    
    private lazy var forYouNavigationController = UINavigationController(rootViewController: forYouViewController)
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupControllers()
    }
    
    // MARK: - Private methods
    private func setupControllers() {
        viewControllers = [buyViewController, forYouNavigationController,
                           searchNavigationController,
                           shoppingCartController]
        tabBar.barTintColor = .systemBackground
        tabBar.backgroundColor = .systemGray6
       // tabBar.unselectedItemTintColor = .systemGray3
    }
}
