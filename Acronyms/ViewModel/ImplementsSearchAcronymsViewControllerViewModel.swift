//
//  ImplementsSearchAcronymsViewControllerViewModel.swift
//  Acronyms
//
//  Created by Javad Mammadbayli on 11/9/22.
//

import Foundation
class ImplementsSearchAcronymsViewControllerViewModel: SearchAcronymsViewControllerViewModel {    
    var longForms = Binding<[LongForm]>(value: [LongForm]())
    
    func getLongForms(forAcronym acronym: String) {
        AcronymParser.shared.getLongForms(forAcronym: acronym) {[weak self] longForms, error in
            self?.longForms.value = longForms
        }
    }
    
    init() {
        
    }
}
