//
//  ViewController.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 30/09/23.
//

import UIKit

class HomeViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
 
    
    
    var viewModel = BooksViewModel()
    

    @IBOutlet var tableView: UITableView!
    var completion: (([String:String])->Void?)?
    let search = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBarSetup()
        tableView.layer.cornerRadius = 20
        configuration()
        
    }
    private func searchBarSetup(){
        
        search.searchBar.delegate = self
        navigationItem.searchController = search
    }
}
extension HomeViewController{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Call the APIManager to update the search query
        ApiManager.shared.updateSearchQuery(query: searchText) { result in
            switch result {
                case .success(let data):
                    // Handle and display the search results in your UI
                self.viewModel.books = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                case .failure(let error):
                    // Handle the error, e.g., show an error message to the user
                    print("API Error: \(error)")
            }
        }
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
        cell.books = books
        cell.author?.text = books?.volumeInfo.authors?[0]
        cell.bookTitle?.text = books?.volumeInfo.title
        cell.genre?.text = books?.volumeInfo.categories?[0]
        cell.bookImage.setImage(with: books?.volumeInfo.imageLinks?.smallThumbnail ?? "hehe")
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookPreviewViewController") as! BookPreviewViewController
        let books = viewModel.books?.items[indexPath.row]
        vc.books = books
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

