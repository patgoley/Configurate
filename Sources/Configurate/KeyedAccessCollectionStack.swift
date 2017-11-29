//
//  KeyedAccessCollectionStack.swift
//  ConfiguratePackageDescription
//
//  Created by Patrick Goley on 11/12/17.
//

protocol KeyedAccessCollectionStack: KeyedAccessCollection, Stack
    where Element: KeyedAccessCollection,
    Iterator.Element.Key == Key,
    Iterator.Element.Value == Value {
    
}

extension KeyedAccessCollectionStack {
    
    public func get(_ key: Key) -> Value? {
        
        for map in self {
            
            if let val = map.get(key) {
                
                return val
            }
        }
        
        return nil
    }
}

extension KeyedAccessCollectionStack where Element == AnyKeyedAccessCollection<Key, Value> {

    mutating func push<KeyedAccessType: KeyedAccessCollection>(_ collection: KeyedAccessType)
        where KeyedAccessType.Key == Key,
        KeyedAccessType.Value == Value {

            let container = collection as? AnyKeyedAccessCollection<Key, Value> ?? AnyKeyedAccessCollection<Key, Value>(collection)

            self.push(container)
    }
}

