//
//  KeyedAccessCollection.swift
//  ConfiguratePackageDescription
//
//  Created by Patrick Goley on 11/12/17.
//

public protocol KeyedAccessCollection {
    
    associatedtype Key: Hashable
    associatedtype Value
    
    func get(_ key: Key) -> Value?
}

public extension KeyedAccessCollection {
    
    subscript(key: Key) -> Value? {
        
        return get(key)
    }
}

public extension KeyedAccessCollection where Value == Any {
    
    subscript<T>(key: Key) -> T? {
        
        return get(key) as? T
    }
}

public struct AnyKeyedAccessCollection<Key: Hashable, Value>: KeyedAccessCollection {
    
    private let _get: (Key) -> Value?
    
    public init<Base: KeyedAccessCollection>(_ base: Base) where Base.Key == Key, Base.Value == Value {
        
        _get = base.get
    }
    
    public init(_ dict: [Key: Value]) {
        
        _get = { (key: Key) -> Value? in
            
            return dict[key]
        }
    }
    
    public func get(_ key: Key) -> Value? {
        
        return _get(key)
    }
}
