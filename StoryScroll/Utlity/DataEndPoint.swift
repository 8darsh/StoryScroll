//
//  DataEndPoint.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 29/09/23.
//

import Foundation

enum DataEndPoint{
    
    case books(searchString: String)
}

// https://www.googleapis.com/books/v1/volumes?q=flowers&filter=free-ebooks&key=AIzaSyAPCE3PhlZywojNWxXVq9ssoepOTH6eN3M
//https://www.googleapis.com/books/v1/volumes?q=three&mistakes&of&my&life&download=epub&key=AIzaSyAPCE3PhlZywojNWxXVq9ssoepOTH6eN3M
extension DataEndPoint:EndPointType{
    var path: String {
        switch self {
        case .books(searchString: let searchString):
            if searchString == ""{
                return "war&key=AIzaSyAPCE3PhlZywojNWxXVq9ssoepOTH6eN3M"
            }else{
                return "\(searchString)&key=AIzaSyAPCE3PhlZywojNWxXVq9ssoepOTH6eN3M"
            }
        }
    }
    
    var baseURL: String {
        switch self {
        case .books:
            return "https://www.googleapis.com/books/v1/volumes?q="
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .books:
            return .get
        }
    }
    
    var body: Encodable? {
        switch self {
        case .books:
            return nil
        }
    }
    
    var headers: [String : String]? {
        ApiManager.commonHeader
    }
    
    
}
