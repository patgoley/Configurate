import XCTest
import Configurate

class ConfigurateTests: XCTestCase {
    
    func testProviderFactory() {
        
        ProcessInfo.processInfo.setEnvironmentVar(name: "hello", value: "world")
        
        let config = Configurate.withDefaults(ProcessInfo.processInfo)
        
        XCTAssertEqual(config["hello"], "world")
    }
    
    func testDictionaryFactory() {
        
        let config = Configurate.withDefaults(["hello": "value"])
        
        XCTAssertEqual(config["hello"], "value")
    }

    static var allTests = [
        ("testProviderFactory", testProviderFactory),
        ("testDictionaryFactory", testDictionaryFactory)
    ]
}

extension ProcessInfo {
    
    func setEnvironmentVar(name: String, value: String) {
        
        setenv(name, value, 1)
    }
}
