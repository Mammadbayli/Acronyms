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
                completion([LongForm](), error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let apiResponse =  try decoder.decode([APIResponse].self, from: data)
                if let forms = apiResponse.first?.longForms, forms.count > 0 {
                    completion(forms, nil)
                } else {
                    completion([LongForm](), .notFound("Could not find a match"))
                }
                
            } catch {
                completion([LongForm](), .parsingError("Cannot parse"))
            }
        }
    }
    
    private init() {}

}
