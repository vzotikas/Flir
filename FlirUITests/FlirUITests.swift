import XCTest

class FlirUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLoginTitle() throws {
        let welcome = app.staticTexts["Login"]
     
        XCTAssert(welcome.exists)
    }
    
    func testLoginButton() throws {
        let login = app.buttons["loginButton"]
     
        XCTAssert(login.exists)
        XCTAssertEqual(login.label, "Login")
    }
    
    func testLoginFormAppearance() throws {
        let loginNavBarTitle = app.staticTexts["Login"]
        
        XCTAssert(loginNavBarTitle.waitForExistence(timeout: 0.5))
    }
    
    func testLoginForm() throws {
        let username = app.textFields["Email"]
        
        XCTAssert(username.exists)
     
        let password = app.secureTextFields["Password"]
        
        XCTAssert(password.exists)
     
        let login = app.buttons["loginButton"]
        
        XCTAssert(login.exists)
        XCTAssertEqual(login.label, "Login")
    }
    
    func testEmail() throws {
        let username = app.textFields["Email"]
        
        username.tap()
        username.typeText("flir@flir.com")
     
        XCTAssertNotEqual(username.value as! String, "")
    }
    
    func testPassword() throws {
        app.secureTextFields.element.tap()
        app.keys["more"].tap()
        app.keys["1"].tap()
        app.keys["2"].tap()
        app.keys["3"].tap()
        app.keys["4"].tap()
        app.keys["5"].tap()
        app.keys["6"].tap()
        app.keyboards.buttons["Return"].tap()
     
        XCTAssertNotEqual(app.secureTextFields.element.value as! String, "")
    }
    
    func testLogin() throws {
        app.buttons["Login"].tap()
        app.textFields.element.tap()
        app.textFields.element.typeText("flir@flir.com")
        app.secureTextFields.element.tap()
        app.secureTextFields.element.typeText("123456")
        app.keyboards.buttons["Return"].tap()
     
        let loginButton = app.buttons["loginButton"]
        
        loginButton.tap()
     
        XCTAssertFalse(loginButton.waitForExistence(timeout: 0.5))
    }
    
    func testFailedLoginAlert() throws {
        app.buttons["Login"].tap()
        app.buttons["loginButton"].tap()
     
        XCTAssert(app.alerts.element.waitForExistence(timeout: 0.5))
     
        app.alerts.element.buttons["OK"].tap()
        
        XCTAssertFalse(app.alerts.element.exists)
    }
    
    func login() throws {
        app.buttons["Login"].tap()
        app.textFields.element.tap()
        app.textFields.element.typeText("flir@flir.com")
        app.secureTextFields.element.tap()
        app.secureTextFields.element.typeText("123456")
        app.keyboards.buttons["Return"].tap()
        app.buttons["loginButton"].tap()
    }
    
    func testLoginLogoutLabel() throws {
        XCTAssertEqual(app.buttons["loginButton"].label, "Login")
     
        try login()
     
        XCTAssertEqual(app.buttons["logoutButton"].label, "Logout")
    }
    
    func testLogout() throws {
        try login()
     
        XCTAssertEqual(app.buttons["logoutButton"].label, "Logout")
     
        app.buttons["logoutButton"].tap()
     
        XCTAssert(app.staticTexts["Login"].exists)
        XCTAssertEqual(app.buttons["loginButton"].label, "Login")
    }
}
