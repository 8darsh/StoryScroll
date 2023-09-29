//
//  ApiManager.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 29/09/23.
//

import Foundation

enum DataError:Error{
    
    case invalidResponse
    case invalidUrl
    case invalidData
    case network(Error?)
}
typealias Handler<T> = (Result<T, DataError>)->Void

class ApiManager:Codable{
    
    static let shared = ApiManager()
    init(){}
    
    func request<T: Codable>(
    
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>
    ){
        guard let url = type.url else{
            completion(.failure(.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        
        if let parameters = type.body{
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        
        request.allHTTPHeaderFields = type.headers
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data, error == nil else{
                completion(.failure(.invalidData))
                return
            }
        
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else{
                
                completion(.failure(.invalidResponse))
                return
            }
            
            do{
                
                let product = try JSONDecoder().decode(modelType, from: data)
                completion(.success(product))
                
            }catch{
                completion(.failure(.network(error)))
            }
            
        }.resume()
    
    }
    static var commonHeader: [String:String]{
        return [
            "Content-Type": "application/json"
        
        ]
    }
}
