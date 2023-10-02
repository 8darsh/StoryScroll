//
//  ViewController.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 30/09/23.
//

import UIKit
import NotificationCenter

class HomeViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    
    
    var viewModel = BooksViewModel()
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var gifImage: UIImageView!
    
    @IBOutlet var timeView: UIView!
    let search = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        timeView.layer.cornerRadius = 20
        
        tableView.layer.cornerRadius = 20
        configuration()
        
        TimerManager.shared.updateTimerCallback = { [weak self] elapsedTime in
            self?.updateTimerLabel(elapsedTime)
//            self!.testParseConnection()
            
        }
    }
//    func testParseConnection(){
//            let myObj = PFObject(className:"FirstClass")
//            myObj["message"] = "Hey ! First message from Swift. Parse is now connected"
//            myObj.saveInBackground { (success, error) in
//                if(success){
//                    print("You are connected!")
//                }else{
//                    print("An error has occurred!")
//                }
//            }
//        }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTimerLabel(UserDefaults.standard.double(forKey: "elapsedTime"))

        let gif = UIImage.gifImageWithName("2")
        gifImage.image = gif?.withHorizontallyFlippedOrientation()
    }

    func updateTimerLabel(_ elapsedTime: TimeInterval) {
        let hours = Int(elapsedTime) / 3600
        let minutes = (Int(elapsedTime) % 3600) / 60
        let seconds = Int(elapsedTime) % 60
        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
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

