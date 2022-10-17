//
//  OnboardingViewController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 14.10.2022.
//

import UIKit

///  Onboarding для новых пользователей
final class OnboardingViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let arialNameFont = "Arial"
        static let arialHebrewBoldNameFont = "Arial Hebrew Bold"
    }
    
    // MARK: - Private Visual Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: view.frame.midY + 150, width: view.bounds.width, height: 40)
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: Constants.arialHebrewBoldNameFont, size: 16)
        label.alpha = 0
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: view.frame.midY + 200, width: view.bounds.width, height: 60)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.font = UIFont(name: Constants.arialNameFont, size: 16)
        label.alpha = 0
        return label
    }()
    
    private lazy var onboardingImageView: UIImageView = {
        let onboardingImage = UIImageView()
        onboardingImage.contentMode = .scaleAspectFit
        onboardingImage.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width,
                                                                   height: view.bounds.height / 3 * 2))
        return onboardingImage
    }()
    
    // MARK: - Initialization
    
    init(title: String, info: String, imageName: String) {
        super.init(nibName: nil, bundle: nil)
        addSubview()
        self.titleLabel.text = title
        self.infoLabel.text = info
        self.onboardingImageView.image = UIImage(named: imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appearanceLabel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hiddenLabel()
    }
    
    // MARK: - Private Methods
    private func addSubview() {
        view.backgroundColor = .systemBackground
        view.addSubview(onboardingImageView)
        view.addSubview(infoLabel)
        view.addSubview(titleLabel)
    }
    
   func hiddenLabel() {
        self.infoLabel.alpha = 0
        self.titleLabel.alpha = 0
    }
    
   func appearanceLabel() {
        UILabel.animate(withDuration: 3) {
            self.infoLabel.alpha = 1
            self.titleLabel.alpha = 1
        }
    }
}
