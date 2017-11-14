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
    
    public init(url: URL) throws {
        
        guard let fileType = url.pathExtension.split(separator: ".").last else {
            
            throw ConfigError.invalidFileFormat
        }
        
        switch fileType {
            
        case "json": try self.init(jsonAtURL: url)
        case "plist": try self.init(plistAtURL: url)
        default: throw ConfigError.invalidFileFormat
        }
    }
    
    public init(plistAtURL url: URL, options: PropertyListSerialization.ReadOptions = [], format: UnsafeMutablePointer<PropertyListSerialization.PropertyListFormat>? = nil) throws {
        
        let data = try Data(contentsOf: url)
        
        if let contents = try PropertyListSerialization.propertyList(from: data, options: options, format: format) as? [String: Any] {
            
            self.init(contents: contents)
            
        } else {
            
            throw ConfigError.invalidFileFormat
        }
    }
    
    public init(jsonAtURL url: URL, options: JSONSerialization.ReadingOptions = []) throws {
        
        let data = try Data(contentsOf: url)
        
        if let contents = try JSONSerialization.jsonObject(with: data, options: options) as? [String: Any] {
            
            self.init(contents: contents)
            
        } else {
            
            throw ConfigError.invalidFileFormat
        }
    }
    
    private init(contents: [String: Any]) {
        
        self.contents = contents
    }
    
    public func get(_ key: String) -> Value? {
        
        return contents[key]
    }
}
