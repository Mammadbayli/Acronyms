//
//  Binding.swift
//  Acronyms
//
//  Created by Javad Mammadbayli on 11/9/22.
//


protocol BindingProtocol<T> {
    typealias Listener<T> = (T) -> Void
    associatedtype T

    var value: T { get }
    var listener: Listener<T>? { get set }
    mutating func bind(_ listener: @escaping Listener<T>)
}

extension BindingProtocol {
    mutating func bind(_ listener: @escaping Listener<T>) {
        self.listener = listener
    }
}

struct Binding<T>: BindingProtocol {    
    var listener: Listener<T>?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }

}
