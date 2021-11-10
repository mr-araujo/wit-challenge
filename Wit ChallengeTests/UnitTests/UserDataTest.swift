//
//  UserDataTest.swift
//  Wit ChallengeTests
//
//  Created by Murillo R. Araújo on 10/11/21.
//

import XCTest
@testable import Wit_Challenge

class UserDataTest: XCTestCase {

    func testDecodeUser() throws {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "User", ofType: "json") else {
            fatalError("Missing file: User.json")
        }
        
        guard let json = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("Unable to convert json to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let userData = try! decoder.decode(User.self, from: jsonData)
        
        XCTAssertEqual("mr-araujo", userData.login)
        XCTAssertEqual("https://avatars.githubusercontent.com/u/14891276?v=4", userData.avatarUrl)
    }
}
