//
//  MapStack.swift
//  ConfiguratePackageDescription
//
//  Created by Patrick Goley on 11/12/17.
//

struct MapStack<K: Hashable, V>: KeyedAccessCollectionStack {
    
    typealias Key = K
    typealias Value = V
    typealias Element = AnyKeyedAccessCollection<Key, Value>
    
    private var stack: [Element]
    
    init<Collection: KeyedAccessCollection>(keyValueCollection: Collection)
        where Collection.Key == Key,
        Collection.Value == Value {
        
        self.stack = [AnyKeyedAccessCollection(keyValueCollection)]
    }
    
    init() {
        
        self.stack = []
    }
    
    mutating func push(_ element: AnyKeyedAccessCollection<Key, Value>) {
        
        stack.append(element)
    }
    
    mutating func pop() -> AnyKeyedAccessCollection<Key, Value> {
        
        guard let last = stack.last else { fatalError("Tried to pop an empty MapStack") }
        
        stack.remove(at: stack.endIndex - 1)
        
        return last
    }
    
    func makeIterator() -> IndexingIterator<[AnyKeyedAccessCollection<Key, Value>]> {
        
        return stack.reversed().makeIterator()
    }
}
