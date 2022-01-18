import Foundation
@testable import Svea
import XCTest

class PlacesDataTest: XCTestCase {
    func testPlaceData() throws {
        let url = "https://secure.closepayment.com/close-admin/1.0/place/meappid?meAppId=50&records=42"
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { data, _, err in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            guard let APIData = data else {
                print("no data found")
                return
            }
            do {
                // decoding API Data...
                let places = try JSONDecoder().decode(APIPlaceData.self, from: APIData)
                
                XCTAssertEqual("Testplats för MO", places.place[0].name)
                XCTAssertEqual(places.place.count, places.total)
                
                for i in places.place.indices {
                    XCTAssertEqual("", places.place[i].website)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
