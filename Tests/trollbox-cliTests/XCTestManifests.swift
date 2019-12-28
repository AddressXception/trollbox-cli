import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(trollbox_cliTests.allTests),
    ]
}
#endif
