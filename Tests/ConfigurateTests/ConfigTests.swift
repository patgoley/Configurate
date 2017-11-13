//
//  ConfigTests.swift
//  ConfigurateTests
//
//  Created by Patrick Goley on 11/12/17.
//

import XCTest
import Configurate

class ConfigTests: XCTestCase {
    
    var userDefaults: UserDefaults!
    
    override func setUp() {
        
        userDefaults = UserDefaults(suiteName: "test")
        userDefaults.removeSuite(named: "test")
        userDefaults.synchronize()
    }
    
    func testDictionaryProvider() {
        
        let config = Config(["hello": "world"])
        
        XCTAssertEqual(config["hello"], "world")
    }
    
    func testUserDefaultsProvider() {
        
        userDefaults.set("cool", forKey: "wow")
        
        let config = Config(userDefaults)
        
        XCTAssertEqual(config["wow"], "cool")
    }
    
    func testProcessInfoProvider() {
        
        ProcessInfo.processInfo.setEnvironmentVar(name: "wow", value: "process")
        
        let config = Config(ProcessInfo.processInfo)
        
        XCTAssertEqual(config["wow"], "process")
    }
    
    func testConfigProvider() {
        
        let config = Config(["key": "first"])
            .include(Config(["key": "second"]))
        
        XCTAssertEqual(config["key"], "second")
    }
    
    func testMultipleProviders() {
        
        userDefaults.set("override", forKey: "hello")
        
        let config = Config()
            .include(["hello": "world"])
            .include([
                "hello": "secondary",
                "otherKey": "otherValue"
                ])
            .include(userDefaults)
        
        XCTAssertEqual(config["hello"], "override")
        XCTAssertEqual(config["otherKey"], "otherValue")
        XCTAssertNil(config["notAKey"])
    }
    
    func testPop() {
        
        var config = Config(["key": "firstValue"])
            .include(["key": "secondValue"])
        
        XCTAssertEqual(config["key"], "secondValue")
        
        config.pop()
        
        XCTAssertEqual(config["key"], "firstValue")
    }
    
    static var allTests = [
        ("testDictionaryProvider", testDictionaryProvider),
        ("testUserDefaultsProvider", testUserDefaultsProvider),
        ("testProcessInfoProvider", testProcessInfoProvider),
        ("testConfigProvider", testConfigProvider),
        ("testMultipleProviders", testMultipleProviders),
        ("testPop", testPop)
    ]
}
