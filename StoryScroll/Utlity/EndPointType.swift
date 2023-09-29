//
//  EndPointType.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 29/09/23.
//

import Foundation

enum HTTPMethods: String{
    case get = "GET"
    case post = "POST"
}

protocol EndPointType{
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    
    var method: HTTPMethods { get }
    var body: Encodable? {get}
    var headers: [String:String]? {get}
}
