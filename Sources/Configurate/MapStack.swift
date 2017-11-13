//
//  MapStack.swift
//  ConfiguratePackageDescription
//
//  Created by Patrick Goley on 11/12/17.
//

struct MapStack<K: Hashable, V>: KeyedAccessCollectionStack {
    
    typealias Key = K
    typealias Value = V
    
    private var stack: [AnyKeyedAccessCollection<Key, Value>]
    
    init<Collection: KeyedAccessCollection>(keyValueCollection: Collection) where Collection.Key == Key, Collection.Value == Value {
        
        self.stack = [AnyKeyedAccessCollection(keyValueCollection)]
    }
    
    init(dictionary: [Key: Value]) {
        
        let anyCollection = AnyKeyedAccessCollection(dictionary)
        
        self.stack = [anyCollection]
    }
    
    init() {
        
        self.stack = []
    }
    
    func get(_ key: Key) -> Value? {
        
        for map in stack.reversed() {
            
            if let val = map.get(key) {
                
                return val
            }
        }
        
        return nil
    }
    
    mutating func push<Collection>(_ collection: Collection) where Collection : KeyedAccessCollection, Key == Collection.Key, Value == Collection.Value {
        
        let container = collection as? AnyKeyedAccessCollection<Key, Value> ?? AnyKeyedAccessCollection(collection)
        
        stack.append(container)
    }
    
    mutating func pop() -> AnyKeyedAccessCollection<Key, Value> {
        
        guard let last = stack.last else {
            
            fatalError("Tried to pop an empty MapStack")
        }
        
        stack.remove(at: stack.endIndex - 1)
        
        return last
    }
}
