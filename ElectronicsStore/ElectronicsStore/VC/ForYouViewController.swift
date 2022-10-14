//
//  TwoViewController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 06.10.2022.
//

import UIKit

/// Экран для вас
final class ForYouViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let titleText = "Для вас"
        static let whatsNewText = "Вот что нового"
        static let orderHasBeenSentText = "Ваш заказ отправлен."
        static let quantityGoodsText = "1 товар, доставка завтра"
        static let processedText = "Обрабатывается"
        static let sentText = "Отправлено"
        static let deliveredText = "Доставлено"
        static let recommendedText = "Рекомендуется вам"
        static let orderNewsText = "Получайте новости о своем заказе в режиме реального времени."
        static let turnOnNotificationsText = "Включите уведомления, чтобы получать новости о своем заказе."
        static let yourDevicesText = "ваши устройства"
        static let showAllText = "Показать все"
        static let chevronSystemImageName = "chevron.compact.right"
        static let appBadgeSystemImageName = "app.badge"
        static let defaultSystemImageName = "person.fill.badge.plus"
        static let orderImageName = "10"
        static let backGroundColor = UIColor(named: "LigtGray3")
        static let keyValue = "newImage"
        
    }
    
    // MARK: - Private Visual Components
    
    private var whatNewLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 180, width: 300, height: 30)
        label.text = Constants.whatsNewText
        label.font = UIFont.systemFont(ofSize: 31, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var recommendedLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 480, width: 300, height: 30)
        label.text = Constants.recommendedText
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var yourDevicesLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 710, width: 300, height: 30)
        label.text = Constants.yourDevicesText
        label.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var showAllLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 275, y: 712.5, width: 100, height: 30)
        label.text = Constants.showAllText
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemBlue
        return label
    }()
    
    private var orderHasBeenSentLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 110, y: 250, width: 200, height: 30)
        label.text = Constants.orderHasBeenSentText
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private var quantityGoodsLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 110, y: 272, width: 200, height: 30)
        label.text = Constants.quantityGoodsText
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.frame = CGRect(x: 10, y: 235, width: view.frame.width - 35, height: 160)
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 15
        backgroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backgroundView.layer.shadowOpacity = 0.7
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundView.layer.shadowRadius = 15
        return backgroundView
    }()
    
    private var orderImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 20, y: 210, width: 70, height: 130)
        image.image = UIImage(named: Constants.orderImageName)
        return image
    }()
    
    private lazy var backgroundLineView: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.frame = CGRect(x: backgroundView.frame.minX, y: 340, width: backgroundView.frame.width, height: 1)
        return line
    }()
    
    private lazy var deliveryStatusProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.frame = CGRect(x: 20, y: 355, width: backgroundView.frame.width - 30, height: 10)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
        progressView.progressTintColor = .systemGreen
        progressView.setProgress(0.5, animated: false)
        return progressView
    }()
    
    private var deliveryNewsImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 20, y: 550, width: 40, height: 40)
        image.image = UIImage(systemName: Constants.appBadgeSystemImageName)
        image.tintColor = .red
        return image
    }()
    
    private var orderNewsLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 80, y: 530, width: 230, height: 100)
        label.numberOfLines = 3
        label.text = Constants.orderNewsText
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var turnOnNotificationsLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 80, y: 580, width: 290, height: 100)
        label.numberOfLines = 3
        label.text = Constants.turnOnNotificationsText
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var processedLabel = makeDeliveryLabel(xCoordinate: 20,
                                                        text: Constants.processedText,
                                                        textColor: .black)
    
    private lazy var sentLabel = makeDeliveryLabel(xCoordinate: 160,
                                                   text: Constants.sentText,
                                                   textColor: .black)
    
    private lazy var deliveredLabel = makeDeliveryLabel(xCoordinate: 280,
                                                        text: Constants.deliveredText,
                                                        textColor: .gray)
    
    private var avatarButton: UIButton?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        makeLineViews()
        addchevronRighdImageView()
        setupNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switchLightTheme()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        switchDarkTheme()
    }
    
    // MARK: - Private Action
    @objc private func avatarButtonAction(_ sender: UIButton) {
        let imagePicerController = UIImagePickerController()
        imagePicerController.sourceType = .photoLibrary
        imagePicerController.delegate = self
        imagePicerController.allowsEditing = true
        present(imagePicerController, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constants.titleText
        let customView = UIView(frame: CGRect(x: 0, y: 30, width: 50, height: 50))
       avatarButton = UIButton(frame: CGRect(x: 0, y: 30, width: 50, height: 50))
        guard let avatarButton = avatarButton else { return }
        avatarButton.addTarget(self, action: #selector(avatarButtonAction), for: .touchUpInside)
        avatarButton.backgroundColor = .systemGray6
        avatarButton.layer.cornerRadius = 25
        avatarButton.clipsToBounds = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customView)
        customView.addSubview(avatarButton)
        guard let data = UserDefaults.standard.value(forKey: Constants.keyValue) as? Data,
              let image = UIImage(data: data)
        else {
            let image = UIImage(
                systemName: Constants.defaultSystemImageName)
            avatarButton.setBackgroundImage(image, for: .normal)
            return
        }
        avatarButton.setBackgroundImage(image, for: .normal)
    }
   
    private func makeLineViews() {
        var yCoordinate: CGFloat = 150
        for _ in 0...1 {
            let line = makeLineView(yCoordinate: yCoordinate, color: .lightGray)
            yCoordinate += 520
            view.addSubview(line)
        }
    }
    
    private func makeDeliveryLabel(xCoordinate: CGFloat, text: String, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.frame = CGRect(x: xCoordinate, y: 360, width: 150, height: 30)
        label.text = text
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }
    
    private func addchevronRighdImageView() {
        var yCoordinate = 280
        for _ in 0...1 {
            let image = UIImageView()
            image.frame = CGRect(x: 335, y: yCoordinate, width: 15, height: 15)
            image.image = UIImage(systemName: Constants.chevronSystemImageName)
            image.tintColor = .systemGray
            view.addSubview(image)
            yCoordinate += 310
        }
    }
    
    private func addSubview() {
        view.addSubview(whatNewLabel)
        view.addSubview(recommendedLabel)
        view.addSubview(yourDevicesLabel)
        view.addSubview(showAllLabel)
        view.addSubview(backgroundView)
        view.addSubview(orderHasBeenSentLabel)
        view.addSubview(orderImageView)
        view.addSubview(quantityGoodsLabel)
        view.addSubview(backgroundLineView)
        view.addSubview(processedLabel)
        view.addSubview(sentLabel)
        view.addSubview(deliveredLabel)
        view.addSubview(deliveryStatusProgressView)
        view.addSubview(deliveryNewsImageView)
        view.addSubview(orderNewsLabel)
        view.addSubview(turnOnNotificationsLabel)
    }
    
    private func switchLightTheme() {
        overrideUserInterfaceStyle = .light
        navigationController?.overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        tabBarController?.tabBar.backgroundColor = Constants.backGroundColor
        tabBarController?.tabBar.unselectedItemTintColor = .darkGray
    }
    
    private func switchDarkTheme() {
        overrideUserInterfaceStyle = .dark
        navigationController?.overrideUserInterfaceStyle = .dark
        tabBarController?.tabBar.backgroundColor = .systemGray6
        tabBarController?.tabBar.unselectedItemTintColor = .lightGray
    }
}

/// UIImagePickerControllerDelegate
 extension ForYouViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     func imagePickerController(_ picker: UIImagePickerController,
                                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
         picker.dismiss(animated: true)
         guard let image = info[.editedImage] as? UIImage else { return }
         let newImage = image.resizeImage(to: CGSize(width: 50, height: 50))
         avatarButton?.setBackgroundImage(newImage, for: .normal)
                  guard let data = newImage.pngData() else { return }
                  UserDefaults.standard.set(data, forKey: Constants.keyValue)
              }
     }
