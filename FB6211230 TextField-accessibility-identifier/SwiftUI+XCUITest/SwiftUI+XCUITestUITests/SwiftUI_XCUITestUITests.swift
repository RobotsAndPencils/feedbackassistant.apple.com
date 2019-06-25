//
//  SwiftUI_XCUITestUITests.swift
//  SwiftUI+XCUITestUITests
//
//  Created by Brandon Evans on 2019-06-24.
//  Copyright © 2019 Robots and Pencils, Inc. All rights reserved.
//

import XCTest

class SwiftUI_XCUITestUITests: XCTestCase {
    func testExample() {
        let application: XCUIApplication = XCUIApplication()
        application.launch()

        let primaryActionButton = application.buttons.matching(identifier: "login.primaryAction").firstMatch

        XCTAssertFalse(primaryActionButton.isEnabled)

        // Commented line below doesn't work, but should
        // let usernameField = application.textFields.matching(identifier: "login.username").firstMatch
        let usernameField = application.otherElements.matching(identifier: "login.username").firstMatch
        usernameField.tap()
        usernameField.typeText("username")

        XCTAssertFalse(primaryActionButton.isEnabled)

        // Commented line below doesn't work, but should
        // let passwordField = application.secureTextFields.matching(identifier: "login.password").firstMatch
        let passwordField = application.otherElements.matching(identifier: "login.password").firstMatch
        passwordField.tap()
        passwordField.typeText("Password1")

        XCTAssertTrue(primaryActionButton.isEnabled)
    }
}
