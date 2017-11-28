//
//  Config.swift
//  ConfiguratePackageDescription
//
//  Created by Patrick Goley on 11/12/17.
//

public struct Config: KeyedAccessCollectionStack, ConfigType {
    
    public typealias Key = String
    public typealias Value = Any
    public typealias Element = AnyKeyedAccessCollection<String, Any>
    
    private var mapStack: MapStack<String, Any>
    
    public init<Provider: KeyedAccessCollection>(_ provider: Provider)
        where Provider.Key == Key,
        Provider.Value == Value {
        
        self.mapStack = MapStack(keyValueCollection: provider)
    }
    
    public init() {
        
        self.mapStack = MapStack<String, Any>()
    }
    
    public func get(_ key: String) -> Any? {
        
        return mapStack.get(key)
    }
    
    public mutating func push(_ element: AnyKeyedAccessCollection<String, Any>) {
        
        mapStack.push(element)
    }
    
    public mutating func pop() -> AnyKeyedAccessCollection<String, Any> {
        
        return mapStack.pop()
    }
    
    public func makeIterator() -> IndexingIterator<[AnyKeyedAccessCollection<Key, Value>]> {
        
        return mapStack.makeIterator()
    }
}

extension Config {
    
    public func include<Provider: KeyedAccessCollection>(_ provider: Provider) -> Config
        where Provider.Key == Key,
        Provider.Value == Value {
            
        var mutableSelf = self
        
        mutableSelf.push(provider)
        
        return mutableSelf
    }
}
