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
        
        let plistURL = Bundle(for: type(of: self)).resourceURL!.appendingPathComponent("test_config.plist")
        
        let configFile = try ConfigFile(plistAtURL: plistURL)
        
        let config = Config(["file_type": "none", "key": "first"])
            .include(configFile)
        
        XCTAssertEqual(config["file_type"], "plist")
        XCTAssertEqual(config["key"], "first")
    }
    
    func testMissingPlistConfigThrows() {
        
        let plistURL = Bundle(for: type(of: self)).resourceURL!.appendingPathComponent("not_a_file.plist")
        
        XCTAssertThrowsError(try ConfigFile(plistAtURL: plistURL))
    }
    
    func testJSONConfig() throws {
        
        let jsonURL = Bundle(for: type(of: self)).resourceURL!.appendingPathComponent("test_config.json")
        
        let configFile = try ConfigFile(jsonAtURL: jsonURL)
        
        let config = Config(["file_type": "none", "key": "first"])
            .include(configFile)
        
        XCTAssertEqual(config["file_type"], "json")
        XCTAssertEqual(config["key"], "first")
    }
    
    func testMissingJSONConfigThrows() {
        
        let jsonURL = Bundle(for: type(of: self)).resourceURL!.appendingPathComponent("not_a_file.json")
        
        XCTAssertThrowsError(try ConfigFile(jsonAtURL: jsonURL))
    }
    
    func testURLInit() throws {
        
        let plistURL = Bundle(for: type(of: self)).resourceURL!.appendingPathComponent("test_config.plist")
        let jsonURL = Bundle(for: type(of: self)).resourceURL!.appendingPathComponent("test_config.json")
        
        let plistConfig = try ConfigFile(url: plistURL)
        let jsonConfig = try ConfigFile(url: jsonURL)
        
        XCTAssertEqual(plistConfig["file_type"], "plist")
        XCTAssertEqual(jsonConfig["file_type"], "json")
    }
    
    func testURLInitErrors() throws {
        
        let textURL = URL(fileURLWithPath: "file.text")
        
        XCTAssertThrowsError(try ConfigFile(url: textURL))
        
        let url = URL(fileURLWithPath: "")
        
        XCTAssertThrowsError(try ConfigFile(url: url))
    }
    
    static var allTests = [
        ("testPlistConfig", testPlistConfig),
        ("testMissingPlistConfigThrows", testMissingPlistConfigThrows),
        ("testJSONConfig", testJSONConfig),
        ("testMissingJSONConfigThrows", testMissingJSONConfigThrows),
    ]
}
