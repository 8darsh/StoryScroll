//
//  BookDescriptionViewController.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 03/10/23.
//

import UIKit
import WebKit
import SafariServices
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
//        bookDescription.layer.cornerRadius = 20
        setDetails()
//        layoutViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TimerManager.shared.startTimer()
        self.bookDescription.layer.cornerRadius = 20
        setDetails()
        if (books?.accessInfo?.pdf.isAvailable)! {
            downloadBtn.isHidden = false
        }else{
            downloadBtn.isHidden = true
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        TimerManager.shared.stopTimer()
    }
    
    
    @IBAction func buyBtnTapped(_ sender: UIButton) {
//        let url = URL(string: (books?.saleInfo.buyLink) ?? "hehe")!
//        webView.load(URLRequest(url: url))
//        webView.uiDelegate = self
//        webView.allowsBackForwardNavigationGestures = true
//        webView.allowsLinkPreview = true
//        webView.navigationDelegate = self
//        view.addSubview(webView)
//        if {
//            UIApplication.shared.open(url)
//        }
        let url = URL(string: (books?.volumeInfo.infoLink) ?? "hehe")!
        let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
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
