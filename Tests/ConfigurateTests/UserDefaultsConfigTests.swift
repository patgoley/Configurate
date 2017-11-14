//
//  UserDefaultsConfigTests.swift
//  ConfigurateTests
//
//  Created by Patrick Goley on 11/12/17.
//

import XCTest
import Configurate

class UserDefaultsConfigTests: XCTestCase {
    
    var userDefaults: UserDefaults!
    
    override func setUp() {
        
        userDefaults = UserDefaults(suiteName: "test")
        userDefaults.removeSuite(named: "test")
        _ = userDefaults.synchronize()
    }
    
    func testUserDefaultsProvider() {
        
        userDefaults.set("value", forKey: "key")
        
        let config = Config(userDefaults)
        
        XCTAssertEqual(config["key"], "value")
    }
    
    static var allTests = [
        ("testUserDefaultsProvider", testUserDefaultsProvider)
    ]
}
