//
//  ConfigTests.swift
//  ConfigurateTests
//
//  Created by Patrick Goley on 11/12/17.
//

import XCTest
import Configurate

class ConfigTests: XCTestCase {
    
    func testDictionaryProvider() {
        
        let config = Config(["hello": "world"])
        
        XCTAssertEqual(config["hello"], "world")
    }
    
    func testConfigProvider() {
        
        let config = Config(["key": "first"])
            .include(Config(["key": "second"]))
        
        XCTAssertEqual(config["key"], "second")
    }
    
    func testMultipleProviders() {
        
        let anyConfig = AnyKeyedAccessCollection<String, Any>(["hello": "first"])
        
        let config = Config()
            .include(anyConfig)
            .include([
                "hello": "second",
                "otherKey": "otherValue"
            ])
            .include([
                "hello": "third"
            ])
        
        XCTAssertEqual(config["hello"], "third")
        XCTAssertEqual(config["otherKey"], "otherValue")
        XCTAssertNil(config["notAKey"])
    }
    
    func testPop() {
        
        var config = Config(["key": "firstValue"])
            .include(["key": "secondValue"])
        
        XCTAssertEqual(config["key"], "secondValue")
        
        let popped = config.pop()
        
        XCTAssertEqual(config["key"], "firstValue")
        XCTAssertEqual(popped["key"], "secondValue")
    }
    
    static var allTests = [
        ("testDictionaryProvider", testDictionaryProvider),
        ("testConfigProvider", testConfigProvider),
        ("testMultipleProviders", testMultipleProviders),
        ("testPop", testPop)
    ]
}
