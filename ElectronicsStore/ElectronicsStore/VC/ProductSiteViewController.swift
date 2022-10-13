//
//  ProductSiteViewController.swift
//  ElectronicsStore
//
//  Created by Алена Панченко on 11.10.2022.
//

import UIKit
import WebKit

/// Сайт продукта
final class ProductSiteViewController: UIViewController {
        
    // MARK: - Private Visual Components
    private lazy var productWebView: WKWebView = {
        let webView = WKWebView()
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 80)
        return webView
    }()
    
    private var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        return progressView
    }()
    
    // MARK: - Public Properties
    var productInfo = ProductInfo()
    
    // MARK: - Private Propertiew
    private var observation: NSKeyValueObservation?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubview()
        goToSite()
        setToolBar()
    }
    
    // MARK: - Private Action
    
    @objc private func goBack() {
        if self.productWebView.canGoBack {
            self.productWebView.goBack()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func goForward() {
        if self.productWebView.canGoForward {
            self.productWebView.goForward()
        }
    }
    
    @IBAction func shareButtonImageAction(_ sender: UIButton) {
             let activity = UIActivityViewController(
                activityItems: [productInfo.pageAdress],
                 applicationActivities: .none
             )
             present(activity, animated: true, completion: .none)
         }
    
    // MARK: - Private Methods
    private func goToSite() {
        guard let productURL = URL(string: productInfo.pageAdress) else { return }
        let request = URLRequest(url: productURL)
        self.productWebView.load(request)
    }
    
    private func setToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        toolBar.isTranslucent = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let spaserButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refrechButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                target: productWebView,
                                                action: #selector(productWebView.reload))
        let forwardButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.right"),
            style: .plain,
            target: self,
            action: #selector(goForward)
        )
        
        let backButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(goBack)
        )
        
        let shareButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(shareButtonImageAction)
        )
        
        progressView.frame.size.width = 250
        let progressButtonItem = UIBarButtonItem(customView: progressView)
        
        toolBar.items = [backButtonItem, forwardButtonItem, progressButtonItem,
                         spaserButtonItem, refrechButtonItem, shareButtonItem]
        productWebView.addSubview(toolBar)
        toolBar.bottomAnchor.constraint(equalTo: productWebView.bottomAnchor, constant: 0).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: productWebView.leadingAnchor, constant: 0).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: productWebView.trailingAnchor, constant: 0).isActive = true
    }
        
    private func addSubview() {
        view.addSubview(productWebView)
        view.addSubview(progressView)
        observation = productWebView.observe(
            \.estimatedProgress,
             options: [.new],
             changeHandler: { [weak self] webView, _ in
                 guard let self = self else { return }
                 self.progressView.progress = Float(webView.estimatedProgress)
             })
    }
}
