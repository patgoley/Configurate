//
//  KeyedAccessCollectionStack.swift
//  ConfiguratePackageDescription
//
//  Created by Patrick Goley on 11/12/17.
//

protocol KeyedAccessCollectionStack: KeyedAccessCollection, Stack where Iterator.Element == AnyKeyedAccessCollection<Key, Value> {
    
    
}

extension KeyedAccessCollectionStack {

    mutating func push<KeyedAccessType: KeyedAccessCollection>(_ collection: KeyedAccessType)
        where KeyedAccessType.Key == Key,
        KeyedAccessType.Value == Value {

            let container = collection as? AnyKeyedAccessCollection<Key, Value> ?? AnyKeyedAccessCollection<Key, Value>(collection)

            self.push(container)
    }
}

