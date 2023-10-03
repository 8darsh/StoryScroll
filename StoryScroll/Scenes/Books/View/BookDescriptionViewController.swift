//
//  BookDescriptionViewController.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 03/10/23.
//

import UIKit
import WebKit

class BookDescriptionViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var bookDescription: UILabel!
    
    @IBOutlet weak var buyBtn: UIButton!
    
    @IBOutlet weak var downloadBtn: UIButton!
    
    var books: volume?
    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDetails()
//        layoutViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDetails()
        if (books?.accessInfo?.pdf.isAvailable)! {
            downloadBtn.isHidden = false
        }else{
            downloadBtn.isHidden = true
        }
        
    }
    
    @IBAction func buyBtnTapped(_ sender: UIButton) {
        let url = URL(string: (books?.volumeInfo.infoLink) ?? "hehe")!
        webView.load(URLRequest(url: url))
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.navigationDelegate = self
        view.addSubview(webView)
    }
    
    @IBAction func downloadBtnTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookPreviewViewController") as! BookPreviewViewController
        vc.books = books
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setDetails(){
        
        self.bookDescription.text = books?.volumeInfo.description
        self.bookImage.setImage(with: books?.volumeInfo.imageLinks?.thumbnail ?? "hehe")
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if !navigationResponse.canShowMIMEType {
            decisionHandler(.download)
        } else {
            decisionHandler(.allow)
        }
    }


    
    

}
