//
//  SearchAcronymsViewControllerViewModel.swift
//  Acronyms
//
//  Created by Javad Mammadbayli on 11/9/22.
//

import Foundation
protocol SearchAcronymsViewControllerViewModel {
    var error: Binding<APIError?> { get set }
    var longForms: Binding<[LongForm]> { get set }
    
    func getLongForms(forAcronym: String) -> Void
}
