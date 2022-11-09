//
//  APIResponse.swift
//  Acronyms
//
//  Created by Javad Mammadbayli on 11/9/22.
//

import Foundation

struct APIResponse: Codable {
    var shortForm: String
    var longForms: [LongForm]
    
    enum CodingKeys: String, CodingKey {
        case shortForm = "sf"
        case longForms = "lfs"
    }
}
