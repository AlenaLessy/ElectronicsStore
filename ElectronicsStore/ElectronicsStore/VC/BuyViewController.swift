//
//  ViewController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 06.10.2022.
//

import UIKit
/// Экран покупки
class BuyViewController: UIViewController {
  
    // MARK: - Constants
    private enum Constants {
          static let tabBarImageName = "laptopcomputer.and.iphone"
        static let tabBarTitle = "Купить"
      }
    
    // MARK: - Private IBoutlet
    
    // MARK: - Private Visual Components
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Initializers
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItemConfigure()
       
    }
    // MARK: - Public Methods
    
    // MARK: - Private Action
    
    // MARK: - Private Methods
    private func tabBarItemConfigure() {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(systemName: Constants.tabBarImageName)
        tabBarItem.title = Constants.tabBarTitle
        self.tabBarItem = tabBarItem
        
    }
}
