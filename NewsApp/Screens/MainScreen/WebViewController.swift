//
//  WebViewController.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 21.04.2024.
//

import UIKit
import WebKit

class WebViewerController: UIViewController {
    // MARK: Properties
    
    private let webView = WKWebView()
    private let url: String
    
    //MARK: LifeCycle
    
    init(with url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        openURL()
    }
    
    //MARK: UI Setup
    
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        
        self.view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: Open URL
    
    private func openURL() {
        print(url)
        guard let url = URL(string: self.url) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.webView.load(URLRequest(url: url))
    }
    
    //MARK: Selectors
    
    @objc private func didTapDone() {
        self.dismiss(animated: true, completion: nil)
    }
}

