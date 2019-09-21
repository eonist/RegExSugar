import XCTest
import RegExSugar

class UnitTest: XCTestCase {
   override func setUp() {
      super.setUp()
   }
   override func tearDown() {
      super.tearDown()
   }
   func testExample() {
      let str: String = "P{color:#00FF00;}/*Paragraph color*/"
      let strSansComment: String = RegExpModifier.removeComments(str)
      XCTAssertEqual(strSansComment, "P{color:#00FF00;}")
   }
   func testPerformanceExample() {
      self.measure { }
   }
}
