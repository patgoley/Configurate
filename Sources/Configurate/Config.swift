//
//  Config.swift
//  ConfiguratePackageDescription
//
//  Created by Patrick Goley on 11/12/17.
//

public struct Config: KeyedAccessCollectionStack, ConfigType {
    
    public typealias Key = String
    public typealias Value = Any
    
    private var mapStack: MapStack<String, Any>
    
    init<Provider: KeyedAccessCollection>(_ providers: Provider...)
        where Provider.Key == Key,
        Provider.Value == Value {
            
        self.mapStack = MapStack(keyValueCollections: providers)
    }
    
    init<ProviderSequence: Sequence>(_ providers: ProviderSequence)
        where ProviderSequence.Element: KeyedAccessCollection,
        ProviderSequence.Element.Key == Key,
        ProviderSequence.Element.Value == Value {
        
        self.mapStack = MapStack(keyValueCollections: providers)
    }
    
    init<Provider: KeyedAccessCollection>(_ provider: Provider) where Provider.Key == Key, Provider.Value == Value {
        
        self.mapStack = MapStack(keyValueCollection: provider)
    }
    
    init(_ provider: [String: Any]) {
        
        self.mapStack = MapStack(dictionary: provider)
    }
    
    init(mapStack: MapStack<String, Any> = MapStack<String, Any>()) {
        
        self.mapStack = mapStack
    }
    
    public func get(_ key: String) -> Any? {
        
        return mapStack.get(key)
    }
    
    mutating func push<KeyedAccessType>(_ collection: KeyedAccessType)
        where KeyedAccessType: KeyedAccessCollection,
        Config.Key == KeyedAccessType.Key,
        Config.Value == KeyedAccessType.Value {
        
        mapStack.push(collection)
    }
    
    func pop() -> AnyKeyedAccessCollection<String, Any> {
        
        return mapStack.pop()
    }
}

extension Config {
    
    public func include<KeyedAccessType>(_ collection: KeyedAccessType) -> Config
        where KeyedAccessType: KeyedAccessCollection,
        KeyedAccessType.Key == Key,
        KeyedAccessType.Value == Any {
            
            var mutableSelf = self
            
            mutableSelf.push(collection)
            
            return mutableSelf
    }
    
    public func include(_ dictionary: [String: Any]) -> Config {
        
        var mutableSelf = self
        
        mutableSelf.push(dictionary)
        
        return mutableSelf
    }
}
