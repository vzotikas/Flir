import XCTest

class FlirUITestsLaunchTests: XCTestCase {
    let app = XCUIApplication()
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        app.launch()

        continueAfterFailure = false
    }
    
    func testLaunch() throws {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        
        add(attachment)
    }
    
    func login() throws {
        app.textFields.element.tap()
        app.textFields.element.typeText("flir@flir.com")
        app.secureTextFields.element.tap()
        app.secureTextFields.element.typeText("123456")
        app.keyboards.buttons["Return"].tap()
        app.buttons["loginButton"].tap()
    }
    
    func testScroll() throws {
        try login()
        
        let mainScrollView = app.scrollViews.element
        
        mainScrollView.swipeUp(velocity: 1000)
        mainScrollView.swipeDown(velocity: 1000)
    }
    
    func testModal() throws {
        try login()
        
        let infoButton = app.buttons["infoButton0"]
        let infoView = app.scrollViews.element

        infoButton.tap()
        infoView.swipeDown()
    }
    
    func testModalClose() throws {
        try login()
        
        let infoButton = app.buttons["infoButton0"]
        let infoCloseButton = app.buttons["infoCloseButton"]
        
        infoButton.tap()
        infoCloseButton.tap()
    }
}
