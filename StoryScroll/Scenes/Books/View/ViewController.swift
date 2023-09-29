//
//  ViewController.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 29/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = BooksViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }
}
extension ViewController{
    
    func configuration(){
        
        initModel()
        observeEvent()
    }
    
    func initModel(){
        
        viewModel.fetchdata()
    }
    
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            
            guard let self else {return}
            
            switch event{
                
            case .loading:
                print("loading")
            case .stopLoading:
                print("stoploading")
            case .dataLoaded:
                print(viewModel.books!)
            case .error(let error):
                print(error)
                
            }
        }
    }
}
