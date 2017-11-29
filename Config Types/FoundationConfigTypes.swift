//
//  FoundationConfigTypes.swift
//  Configurate
//
//  Created by Patrick Goley on 11/28/17.
//

import Foundation

extension UserDefaults: ConfigType {
    
    public func get(_ key: String) -> Any? {
        
        return object(forKey: key)
    }
}

extension ProcessInfo: ConfigType {
    
    public func get(_ key: String) -> Any? {
        
        return environment[key]
    }
}
