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
      testRemoveComments()
      testReplace()
   }
   func testPerformanceExample() {
      self.measure { }
   }
}
extension UnitTest {
   /**
    * testRemoveComments
    */
   func testRemoveComments() {
      let str: String = "P{color:#00FF00;}/*Paragraph color*/"
      let strSansComment: String = RegExpModifier.removeComments(str)
      XCTAssertEqual(strSansComment, "P{color:#00FF00;}")
   }
   /**
    * testReplace
    */
   func testReplace() {
      let string = "blue:0000FF green:00FF00 red:FF0000"
      let ptrn: String = "(\\w+?)\\:([A-Z0-9]+?)(?: |$)"
      let theResult: String = string.replace(pattern: ptrn) { result in
         let beginning = result.stringRange(string, key: 1) // Capturing group 1
         let newBegginingStr: String = { // Manipulate the string a bit
            let theStr: String = .init(string[beginning])
            return theStr.uppercased()
         }()
         let end = result.stringRange(string, key: 2) // Capturing group 2
         let newEndStr: String = .init(string[end]) // Keep the same string
         return [(beginning, newBegginingStr), (end, newEndStr)]
      }
      Swift.print("theResult:  \(theResult)") // BLUE:0000FF GREEN:00FF00 RED:FF0000
      XCTAssertEqual(theResult, "BLUE:0000FF GREEN:00FF00 RED:FF0000")
   }
}
