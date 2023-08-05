//
//  WebViewController.swift
//  Project16
//
//  Created by Derya Çayıroğlu on 5.08.2023.
//

import WebKit
import UIKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    var webSite: String!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: webSite)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
