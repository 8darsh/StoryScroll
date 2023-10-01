//
//  BooksViewModel.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 29/09/23.
//

import Foundation
import UIKit
final class BooksViewModel{
    
    var books: BookModel?
    var eventHandler:((_ event: Event)->Void)?
    func fetchdata(){
        self.eventHandler?(.loading)
        let searchQuery = ApiManager.shared.searchQuery
        ApiManager.shared.request(modelType: BookModel.self, type: DataEndPoint.books(searchString: searchQuery)) { response in
            self.eventHandler?(.stopLoading)
            switch response{
                
            case .success(let book):
                self.books = book
                self.eventHandler?(.dataLoaded)
                
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    
}

extension BooksViewModel{
    enum Event{
        
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        
    }
}
