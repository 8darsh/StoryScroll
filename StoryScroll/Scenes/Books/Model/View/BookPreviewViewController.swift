//
//  BookPreviewViewController.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 01/10/23.
//

import UIKit
import WebKit
class BookPreviewViewController: UIViewController {
 
    
    @IBOutlet var loading: UIActivityIndicatorView!
    
    var books: volume?{
        didSet{
            
        }
    }
    
    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layoutViews()
        configureWebView()
        
    }
    
    
    
    func configureWebView(){

        let url = URL(string: (books?.accessInfo?.webReaderLink) ?? "hehe")!
        webView.load(URLRequest(url: url))
    }
    
    func layoutViews() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
   
    
    func setDetails(){
//        self.bookTitle.text = books?.volumeInfo.title
//        let url = URL(string: books?.volumeInfo.previewLink)
//        
//        if let data = Data(con)
//        self.bookPreview.text =
    }
    
    

}
