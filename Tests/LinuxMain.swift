import XCTest
@testable import ConfigurateTests

XCTMain([
    testCase(ConfigTests.allTests),
    testCase(ProcessInfoConfigTests.allTests),
    //    testCase(UserDefaultsConfigTests.allTests), //FIXME: Does not work on Linux currently
])
