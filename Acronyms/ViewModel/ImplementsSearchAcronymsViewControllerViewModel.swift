//
//  ImplementsSearchAcronymsViewControllerViewModel.swift
//  Acronyms
//
//  Created by Javad Mammadbayli on 11/9/22.
//

import Foundation
class ImplementsSearchAcronymsViewControllerViewModel: SearchAcronymsViewControllerViewModel {    
    var longForms = Binding<[LongForm]>(value: [LongForm]())
    private var timer: Timer?
    
    func getLongForms(forAcronym acronym: String) {
        timer?.invalidate()
        
        guard acronym.count > 1 else {
            longForms.value = [LongForm]()
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            AcronymParser.shared.getLongForms(forAcronym: acronym) {[weak self] longForms, error in
                self?.longForms.value = longForms
            }
        }
        
        
     
    }
    
    init() {
        
    }
}
