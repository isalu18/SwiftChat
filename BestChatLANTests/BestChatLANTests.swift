//
//  BestChatLANTests.swift
//  BestChatLANTests
//
//  Created by Isaac Sanchez on 28/03/22.
//

import XCTest
import Firebase
@testable import BestChatLAN

class MockUser {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

class BestChatLANTests: XCTestCase {
    
    let chatViewController = ChatViewController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMessageCellRows() {
        let rows = chatViewController.totalRows
        
        XCTAssertEqual(rows, 2)
    }
}
