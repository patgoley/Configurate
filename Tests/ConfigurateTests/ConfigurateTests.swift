import XCTest
@testable import Configurate

class ConfigurateTests: XCTestCase {
    
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
    
    func testProviderFactory() {
        
        userDefaults.set("value", forKey: "hello")
        
        let config = Configurate.withDefaults(userDefaults)
        
        XCTAssertEqual(config["hello"], "value")
    }
    
    func testDictionaryFactory() {
        
        let config = Configurate.withDefaults(["hello": "value"])
        
        XCTAssertEqual(config["hello"], "value")
    }
    
    func testPop() {
        
        var config = Config(["key": "firstValue"])
            .include(["key": "secondValue"])
        
        XCTAssertEqual(config["key"], "secondValue")
        
        config.pop()
        
        XCTAssertEqual(config["key"], "firstValue")
    }

    static var allTests = [
        ("testExample", testDictionaryProvider),
        ("testMultipleProviders", testMultipleProviders)
    ]
}

extension ProcessInfo {
    
    func setEnvironmentVar(name: String, value: String, overwrite: Bool = true) {
        
        setenv(name, value, overwrite ? 1 : 0)
    }
}
