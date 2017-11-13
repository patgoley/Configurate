//
//  ConfigFileTests.swift
//  ConfigurateTests
//
//  Created by Patrick Goley on 11/12/17.
//

import XCTest
import Configurate

class ConfigFileTests: XCTestCase {
    
    func testPlistConfig() throws {
        
        if !TestHelpers.isXcodeEnvironment() {
            
            return
        }
        
        let plistURL = Bundle(for: type(of: self)).resourceURL!.appendingPathComponent("test_config.plist")
        
        let configFile = try ConfigFile.plist(atURL: plistURL)
        
        let config = Config(["file_type": "none", "key": "first"])
            .include(configFile)
        
        XCTAssertEqual(config["file_type"], "plist")
        XCTAssertEqual(config["key"], "first")
    }
    
    func testMissingPlistConfigThrows() {
        
        let plistURL = Bundle(for: type(of: self)).resourceURL!.appendingPathComponent("not_a_file.plist")
        
        XCTAssertThrowsError(try ConfigFile.plist(atURL: plistURL))
    }
    
    func testJSONConfig() throws {
        
        if !TestHelpers.isXcodeEnvironment() {
            
            return
        }
        
        let plistURL = Bundle(for: type(of: self)).resourceURL!.appendingPathComponent("test_config.json")
        
        let configFile = try ConfigFile.json(atURL: plistURL)
        
        let config = Config(["file_type": "none", "key": "first"])
            .include(configFile)
        
        XCTAssertEqual(config["file_type"], "json")
        XCTAssertEqual(config["key"], "first")
    }
    
    func testMissingJSONConfigThrows() {
        
        let plistURL = Bundle(for: type(of: self)).resourceURL!.appendingPathComponent("not_a_file.json")
        
        XCTAssertThrowsError(try ConfigFile.json(atURL: plistURL))
    }
    
    static var allTests = [
        ("testPlistConfig", testPlistConfig),
        ("testMissingPlistConfigThrows", testMissingPlistConfigThrows),
        ("testJSONConfig", testJSONConfig),
        ("testMissingJSONConfigThrows", testMissingJSONConfigThrows),
    ]
}
