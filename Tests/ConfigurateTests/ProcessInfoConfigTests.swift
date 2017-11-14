//
//  ProcessInfoConfigTests.swift
//  ConfigurateTests
//
//  Created by Patrick Goley on 11/12/17.
//

import XCTest
import Configurate

class ProcessInfoConfigTests: XCTestCase {
    
    func testProcessInfoProvider() {
        
        ProcessInfo.processInfo.setEnvironmentVar(name: "wow", value: "process")
        
        let config = Config(ProcessInfo.processInfo)
        
        XCTAssertEqual(config["wow"], "process")
    }
    
    static var allTests = [
        ("testProcessInfoProvider", testProcessInfoProvider)
    ]
}
