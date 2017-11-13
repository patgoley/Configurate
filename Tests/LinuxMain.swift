import XCTest
@testable import ConfigurateTests

XCTMain([
    testCase(ConfigurateTests.allTests),
    testCase(ConfigTests.allTests),
])
