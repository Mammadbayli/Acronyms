//
//  LongForm.swift
//  Acronyms
//
//  Created by Javad Mammadbayli on 11/9/22.
//

import Foundation

struct LongForm: Codable {
    var longForm: String
    var frequency: Int
    var since: Int
    
    enum CodingKeys: String, CodingKey {
        case longForm = "lf"
        case frequency = "freq"
        case since
    }
}
