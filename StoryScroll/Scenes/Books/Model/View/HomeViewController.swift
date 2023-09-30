//
//  ViewController.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 30/09/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = BooksViewModel()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchdata()
        self.tableView.reloadData()
    }
}
extension HomeViewController{
    
    func configuration(){
        
        initViewModel()
        observeEvent()
        
    }
    
    func initViewModel(){
        viewModel.fetchdata()
    }
    
    func observeEvent(){
        
        viewModel.eventHandler = {
            [weak self] event in
            guard let self else {return}
            
            switch event{
                
            case .loading:
                print("Loading")
            case .stopLoading:
                print("Stop Loading")
            case .dataLoaded:
                print("Data Loaded")
               
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books?.items.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BooksTableViewCell
        
        let books = viewModel.books?.items[indexPath.row]
        cell.author?.text = books?.volumeInfo.authors?[0]
        cell.bookTitle?.text = books?.volumeInfo.title
        cell.genre?.text = books?.volumeInfo.categories?[0]
        cell.bookImage.setImage(with: books?.volumeInfo.imageLinks?.smallThumbnail ?? "hehe")
        cell.layer.cornerRadius = 20
    

        
        return cell
    }
}

