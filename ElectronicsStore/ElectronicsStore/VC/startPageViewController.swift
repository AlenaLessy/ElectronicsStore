//
//  AvatarSelectionViewController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 12.10.2022.
//

import UIKit

/// Выбор аватарки
final class StartPageViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let entryButtonTitle = "Войти"
    }

    // Private Visual Components
    private lazy var entryButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.gray, for: .normal)
        btn.setTitle(Constants.entryButtonTitle, for: .normal)
        btn.frame = CGRect(x: 200,
                           y: view.frame.maxY - 200,
                           width: 200,
                           height: 30)
        btn.addTarget(self, action: #selector(entryButtonAction), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
  
    }
    
    // MARK: - Private Action
    
    @objc private func entryButtonAction(_ senser: UIButton) {
        
    }
    
    // MARK: - Private Method
    
    private func addSubview() {
        view.backgroundColor = .black
        view.addSubview(entryButton)
    }
}
