//
//  AvatarSelectionViewController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 12.10.2022.
//

import UIKit

/// StartPageViewController для онбординга пользователей
final class StartPageViewController: UIPageViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let entryButtonTitle = "GET STARTED!"
        static let nextButtonTitle = "NEXT"
        static let skipButtonTitle = "SKIP"
        static let pageOneTitle = "Track Your Cycle"
        static let pageTwoTitle = "Plan Your Pregnancy"
        static let pageThreeTitle = "Daily Health Insight"
        static let pageOneInfo = "Manage irregular period and learn how to improve your period"
        static let pageTwoInfo = "Favorable days are impornant. Vestibulum rutrum quam vitae fringila tineidunt"
        static let pageThreeInfo = "Personal health insight. Vestibulum runrum quam vitae fringilla tineidunt"
        static let pageOneImageName = "page1"
        static let pageTwoImageName = "page2"
        static let pageThreeImageName = "page3"
        static let userDefaultsNewKey = "NewKey"
        static let userDefaultsValue = "Value"
    }
    
    // MARK: - Private Visual Components
    private lazy var entryButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.setTitle(Constants.entryButtonTitle, for: .normal)
        btn.frame = CGRect(x: 0, y: view.bounds.maxY - 100, width: 200, height: 30)
        btn.center.x = view.center.x
        btn.addTarget(self, action: #selector(entryAndSkipButtonAction), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    private lazy var skipButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.gray, for: .normal)
        btn.setTitle(Constants.skipButtonTitle, for: .normal)
        btn.frame = CGRect(x: 15,
                           y: view.bounds.maxY - 100,
                           width: 50,
                           height: 30)
        btn.addTarget(self, action: #selector(entryAndSkipButtonAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.gray, for: .normal)
        btn.setTitle(Constants.nextButtonTitle, for: .normal)
        btn.frame = CGRect(x: 300,
                           y: view.bounds.maxY - 100,
                           width: 50,
                           height: 30)
        btn.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 0, y: view.bounds.maxY - 100, width: 200, height: 30)
        pageControl.center.x = view.center.x
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = currentPage
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.addTarget(self, action: #selector(pageControlAction), for: .valueChanged)
        setViewControllers([pages[currentPage]], direction: .forward, animated: true, completion: nil)
        return pageControl
    }()
    
    // MARK: - Public Properties
    
    var pages: [UIViewController] = [
        OnboardingViewController(title: Constants.pageOneTitle,
                                 info: Constants.pageOneInfo,
                                 imageName: Constants.pageOneImageName),
        OnboardingViewController(title: Constants.pageTwoTitle,
                                 info: Constants.pageTwoInfo,
                                 imageName: Constants.pageTwoImageName),
        OnboardingViewController(title: Constants.pageThreeTitle,
                                 info: Constants.pageThreeInfo,
                                 imageName: Constants.pageThreeImageName)
    ]
    
    var currentPage = 0
    
    // MARK: - Initialization
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Private Action
    @objc func pageControlAction(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func nextButtonAction(_ sender: UIButton) {
        pageControl.currentPage += 1
        goNextPage()
    }
    
    @objc func entryAndSkipButtonAction(_ sender: UIButton) {
        let viewController = MainTabBarController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
        let userDefaults = UserDefaults.standard
        userDefaults.set(Constants.userDefaultsValue, forKey: Constants.userDefaultsNewKey)
    }
   
    // MARK: - Private Method
    
    private func configureUI() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .black
        view.addSubview(entryButton)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(pageControl)
        delegate = self
        dataSource = self
    }
    
    private func configurePageControl(_ isLastPage: Bool) {
        nextButton.isHidden = isLastPage
        skipButton.isHidden = isLastPage
        entryButton.isHidden = !isLastPage
        guard let pageControl = view.subviews.first(where: { $0 is UIPageControl }) as? UIPageControl else { return }
        pageControl.isHidden = isLastPage
    }
    
    private func goNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    private func goPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
}

/// UIPageViewControllerDelegate
extension StartPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let viewController = pendingViewControllers.first,
              viewController is OnboardingViewController else { return }
        configurePageControl(viewController === pages.last)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first
        else { return }
        guard let currentIndex = pages.firstIndex(of: viewController) else { return }
        pageControl.currentPage = currentIndex
    }
}

///  UIPageViewControllerDataSource
extension StartPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController)
        else { return nil }
        guard currentIndex == 0 else { return pages[currentIndex - 1] }
        return pages.last
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController)
        else { return nil }
        guard currentIndex < pages.count - 1 else { return pages.first }
        return pages[currentIndex + 1]
        
    }

}
