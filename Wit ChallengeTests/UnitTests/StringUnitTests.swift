//
//  StringUnitTests.swift
//  Wit ChallengeTests
//
//  Created by Murillo R. Araújo on 10/11/21.
//

import XCTest
@testable import Wit_Challenge

class StringUnitTests: XCTestCase {
    
    func testRemovingSpaces() throws {
        
        // given
        let input: String = "Unit Test"
        let expected: String = "UnitTest"
        
        // when
        let result =  input.removingSpaces()
        
        // then
        XCTAssertEqual(expected, result)
    }
}
