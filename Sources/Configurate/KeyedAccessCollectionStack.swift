//
//  KeyedAccessCollectionStack.swift
//  ConfiguratePackageDescription
//
//  Created by Patrick Goley on 11/12/17.
//

protocol KeyedAccessCollectionStack: KeyedAccessCollection {
    
    mutating func push<KeyedAccessType: KeyedAccessCollection>(_ collection: KeyedAccessType)
        where KeyedAccessType.Key == Key,
        KeyedAccessType.Value == Value
    
    @discardableResult mutating func pop() -> AnyKeyedAccessCollection<Key, Value >
}

extension KeyedAccessCollectionStack {
    
    mutating func push<KeyedAccessTypeSequence: Sequence>(contentsOf keyValueCollections: KeyedAccessTypeSequence)
        where KeyedAccessTypeSequence.Element: KeyedAccessCollection,
        KeyedAccessTypeSequence.Element.Key == Key,
        KeyedAccessTypeSequence.Element.Value == Value {
        
        for collection in keyValueCollections {
            
            push(collection)
        }
    }
    
    mutating public func push(_ dictionary: [Key: Value]) {
        
        let boxed = AnyKeyedAccessCollection(dictionary)
        
        push(boxed)
    }
}
