//
//  AcronymsTests.swift
//  AcronymsTests
//
//  Created by Javad Mammadbayli on 11/9/22.
//

import XCTest
@testable import Acronyms

final class AcronymsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPIRequestor() {
        //test API requestor get method
    }

    func testAPIParserSuccess() {
        let parser = AcronymParser.shared
        var result = [LongForm]()
        var error: APIError?
        let expectation = expectation(description: "expect api response")
        
        parser.getLongForms(forAcronym: "usa") { _result, _error in
            result = _result
            error = _error
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
        
        XCTAssert(result.count > 0, "count should be more than 0")
        XCTAssertNil(error)
    }
    
    func testAPIParserFailureWhenLengthisOne() {
        let parser = AcronymParser.shared
        var result = [LongForm]()
        var error: APIError?
        let expectation = expectation(description: "expect api response")
        
        parser.getLongForms(forAcronym: "u") { _result, _error in
            result = _result
            error = _error
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
        
        XCTAssert(result.count == 0, "count should be 0")
        XCTAssertNotNil(error)
    }
    
    func testAPIParserFailureWhenTooLong() {
        let parser = AcronymParser.shared
        var result = [LongForm]()
        var error: APIError?
        let expectation = expectation(description: "expect api response")
        
        parser.getLongForms(forAcronym: "usfsfsfsfdsfsfsf") { _result, _error in
            result = _result
            error = _error
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
        
        XCTAssert(result.count == 0, "count should be 0")
        XCTAssertNotNil(error)
    }
    
    func testBinding() {
        var binding = Binding<String>(value: "")
        var bindingCalled = false
        binding.bind { val in
            bindingCalled = true
        }
        
        binding.value = "new value"
        
        XCTAssertTrue(bindingCalled)
    }
    
    func testSearchSuccess() {
        let viewModel = ImplementsSearchAcronymsViewControllerViewModel()
        let expectation = expectation(description: "seaerch pass expectation")
        
        viewModel.longForms.bind { _ in
            expectation.fulfill()
        }
        
        viewModel.getLongForms(forAcronym: "usa")
        
        wait(for: [expectation], timeout: 30)
        
        XCTAssert(viewModel.longForms.value.count > 0)
    }
    
    func testSearchError() {
        let viewModel = ImplementsSearchAcronymsViewControllerViewModel()
        let expectation = expectation(description: "search fail expectation")
        
        viewModel.error.bind { err in
            expectation.fulfill()
        }
        
        viewModel.getLongForms(forAcronym: "usadsdfdfsfsfsfg")
        
        wait(for: [expectation], timeout: 30)
    }
    
    func testSearchThrottling() {
        let viewModel = ImplementsSearchAcronymsViewControllerViewModel()
        var numberOfTimesCalled = 0
        let expectation1 = expectation(description: "throttling pass expectation1")
        
        viewModel.longForms.bind { _ in
            numberOfTimesCalled += 1
        }
        
        viewModel.getLongForms(forAcronym: "usa")
        viewModel.getLongForms(forAcronym: "usa")
        
        XCTWaiter.wait(for: [expectation1], timeout: 5)
        
        XCTAssertEqual(numberOfTimesCalled, 1)
    }
    
    func testSearchNotThrottling() {
        let viewModel = ImplementsSearchAcronymsViewControllerViewModel()
        var numberOfTimesCalled = 0
        
        let expectation1 = expectation(description: "throttling pass expectation1")
        let expectation2 = expectation(description: "throttling pass expectation2")
        
        var expectations = [expectation1, expectation2]
        
        viewModel.longForms.bind { _ in
            numberOfTimesCalled += 1
            
            expectations.popLast()?.fulfill()
        }
        
        viewModel.getLongForms(forAcronym: "us")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            viewModel.getLongForms(forAcronym: "us")
        }
        
        wait(for: expectations, timeout: 30)
        
        XCTAssert(numberOfTimesCalled == 2)
    }
}
