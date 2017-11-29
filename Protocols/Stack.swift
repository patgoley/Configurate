//
//  Stack.swift
//  ConfiguratePackageDescription
//
//  Created by Patrick Goley on 11/18/17.
//

protocol Stack: Sequence {
    
    mutating func push(_ element: Element)
    
    mutating func pop() -> Element
}
