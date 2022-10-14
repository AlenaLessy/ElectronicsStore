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
        label.frame = CGRect(x: 0, y: view.frame.minY + 400, width: view.bounds.width, height: 40)
        label.textAlignment = .center
        label.font = UIFont(name: Constants.arialHebrewBoldNameFont, size: 16)
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: titleLabel.frame.maxY + 5, width: view.bounds.width, height: 60)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.font = UIFont(name: Constants.arialNameFont, size: 16)
        return label
    }()
    
    private var onboardingImageView: UIImageView = {
        let onboardingImage = UIImageView()
        onboardingImage.contentMode = .scaleAspectFit
        onboardingImage.translatesAutoresizingMaskIntoConstraints = false
        return onboardingImage
    }()
    
    // MARK: - Initialization
    
    init(title: String, info: String, imageName: String) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        infoLabel.text = info
        onboardingImageView.image = UIImage(named: imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        onboardingImageConstrains()
    }
    
    // MARK: - Private Methods
    private func addSubview() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(onboardingImageView)
    }
    
    // MARK: - Constraints
    
    private func onboardingImageConstrains() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: onboardingImageView, attribute: .top, relatedBy: .equal,
                               toItem: view, attribute: .top, multiplier: 1, constant: 100),
            NSLayoutConstraint(item: onboardingImageView, attribute: .width, relatedBy: .equal,
                               toItem: view, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: onboardingImageView, attribute: .height, relatedBy: .equal,
                               toItem: view, attribute: .width, multiplier: 1, constant: 0)
        ])
    }
}
