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
        
        userDefaults.set("cool", forKey: "wow")
        
        let config = Config(userDefaults)
        
        XCTAssertEqual(config["wow"], "cool")
    }
    
    static var allTests = [
        ("testUserDefaultsProvider", testUserDefaultsProvider)
    ]
}
