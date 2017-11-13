//
//  ConfigFile.swift
//  ConfiguratePackageDescription
//
//  Created by Patrick Goley on 11/12/17.
//

import Foundation

public enum ConfigError: Error {
    
    case invalidFileFormat
}

public struct ConfigFile: ConfigType {
    
    public typealias Key = String
    public typealias Value = Any
    
    let contents: [String: Any]
    
    init(contents: [String: Any]) {
        
        self.contents = contents
    }
    
    public func get(_ key: String) -> Value? {
        
        return contents[key]
    }
    
    public static func json(atURL url: URL, options: JSONSerialization.ReadingOptions = []) throws -> ConfigFile {
        
        let data = try Data(contentsOf: url)
        
        if let contents = try JSONSerialization.jsonObject(with: data, options: options) as? [String: Any] {
            
            return ConfigFile(contents: contents)
            
        } else {
            
            throw ConfigError.invalidFileFormat
        }
    }
    
    public static func plist(atURL url: URL, options: PropertyListSerialization.ReadOptions = [], format: UnsafeMutablePointer<PropertyListSerialization.PropertyListFormat>? = nil) throws -> ConfigFile {
        
        let data = try Data(contentsOf: url)
        
        if let contents = try PropertyListSerialization.propertyList(from: data, options: options, format: format) as? [String: Any] {
            
            return ConfigFile(contents: contents)
            
        } else {
            
            throw ConfigError.invalidFileFormat
        }
    }
}
