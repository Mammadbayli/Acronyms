//
//  AcronymParser.swift
//  Acronyms
//
//  Created by Javad Mammadbayli on 11/9/22.
//

import Foundation

class AcronymParser {
    static let shared = AcronymParser()
    
    func getLongForms(forAcronym acronym: String, completion: @escaping ([LongForm], APIError?) -> Void) {
        APIRequestor.shared.getLongForms(forAcronym: acronym) { data, error in
            guard let data else {
                completion([LongForm](), .networkError("Check your internet"))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let apiResponse =  try decoder.decode([APIResponse].self, from: data)
                completion(apiResponse.first?.longForms ?? [LongForm](), nil)
            } catch {
                completion([LongForm](), .parsingError("Cannot parse"))
            }
        }
    }
    
    private init() {}

}
