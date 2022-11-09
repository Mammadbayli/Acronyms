//
//  APIRequestor.swift
//  Acronyms
//
//  Created by Javad Mammadbayli on 11/9/22.
//

import Foundation

enum APIError: Error {
    case badURL
    case notFound(String)
    case networkError(String)
    case parsingError(String)
    case unknown(String)
}

class APIRequestor {
    static let shared = APIRequestor()
    
    func get(url: URL, completion: @escaping (Data?, APIError?) -> Void) {
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            if let data {
                completion(data, nil)
            } else {
                completion(nil, .networkError("Check your internet connection"))
            }
            
        }.resume()
    }
    
    func getLongForms(forAcronym acronym: String, completion: @escaping (Data?, APIError?) -> Void) {
        guard var url = URL(string: Constants.backendURL) else {
            completion(nil, .badURL)
            return
        }
        
        url.append(path: "dictionary.py")
        url.append(queryItems: [URLQueryItem(name: "sf", value: acronym)])
        
        get(url: url, completion: completion)
    }
    
    private init() {}
}
