//
//  ConfigType.swift
//  ConfiguratePackageDescription
//
//  Created by Patrick Goley on 11/12/17.
//

import Foundation

public protocol ConfigType: KeyedAccessCollection where Key == String, Value == Any {
    
}

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
