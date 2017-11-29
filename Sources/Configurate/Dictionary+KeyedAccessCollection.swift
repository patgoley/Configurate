//
//  Dictionary+KeyedAccessCollection.swift
//  Configurate
//
//  Created by Patrick Goley on 11/16/17.
//

extension Dictionary: KeyedAccessCollection {
    
    public func get(_ key: Key) -> Value? {
        
        return self[key]
    }
}
