//
//  BooksViewModel.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 29/09/23.
//

import Foundation

final class BooksViewModel{
    
    var books: BookModel?
    var eventHandler:((_ event: Event)->Void)?
    func fetchdata(){
        self.eventHandler?(.loading)
        ApiManager.shared.request(modelType: BookModel.self, type: DataEndPoint.books(searchString: "flower")) { response in
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
