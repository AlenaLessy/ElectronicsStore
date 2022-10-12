//
//  DetailsViewController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 12.10.2022.
//

import UIKit
import WebKit

// Подробности
final class DetailsViewController: UIViewController {

    // MARK: - Public Properties
    var details: URL?
    
    // MARK: - Visual Components
    private lazy var detailsWebView: WKWebView = {
        let webView = WKWebView()
        webView.frame = CGRect(x: 0, y: 10, width: view.frame.width, height: view.frame.height)
        return webView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(detailsWebView)
        goToSite()
    }
    
    // MARK: - Private Methods
    private func goToSite() {
        guard let detailsURL = details else { return }
        let request = URLRequest(url: detailsURL)
        self.detailsWebView.load(request)
    }
}
