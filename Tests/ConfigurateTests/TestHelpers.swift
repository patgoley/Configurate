//
//  TestHelpers.swift
//  ConfigurateTests
//
//  Created by Patrick Goley on 11/12/17.
//

import Foundation

struct TestHelpers {
    
    static let isXcodeEnvironment: Bool = {
        
        return UserDefaults.standard.bool(forKey: "com.configurate.isXcodeEnv")
    }()
}
