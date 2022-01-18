import XCTest

class FlirUITestsLaunchTests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func chackElements() throws {
        let app = XCUIApplication()
        app.launch()
        
        let placeIcon = app.images["placeIcon1"]
        let placeName = app.staticTexts["placeName1"]
        
        XCTAssertTrue(placeIcon.exists)
        XCTAssertTrue(placeName.exists)
    }
    
    func testScroll() throws {
        let app = XCUIApplication()
        app.launch()
        
        let mainScrollView = app.scrollViews.element
        
        mainScrollView.swipeUp(velocity: 1000)
        mainScrollView.swipeUp(velocity: 2000)
        mainScrollView.swipeDown(velocity: 1000)
        mainScrollView.swipeDown(velocity: 2000)
    }
    
    func testModal() throws {
        let app = XCUIApplication()
        app.launch()
        
        let infoView = app.scrollViews.element
        let infoButton = app.buttons.firstMatch
        
        infoButton.tap()
        infoView.swipeDown()
    }
    
    func testModalClose() throws {
        let app = XCUIApplication()
        app.launch()
        
        let infoButton = app.buttons["infoButton1"]
        let infoCloseButton = app.buttons["infoCloseButton"]
        
        infoButton.tap()
        infoCloseButton.tap()
    }
}
