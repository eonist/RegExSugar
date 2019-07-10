import Foundation

extension String {
   func match(_ pattern: String!, _ options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive) -> [String] { // Convenince
      return RegExp.match(self, pattern: pattern, options: options)
   }
   func matches(_ pattern: String!, _ options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive) -> [NSTextCheckingResult] {//Convenince
      return RegExp.matches(self, pattern: pattern, options: options)
   }
   func test(_ pattern: String) -> Bool {/*Convenince*/
      return RegExp.test(self, pattern: pattern)
   }
   func replace(_ pattern: String, _ replacement: String) -> String {/*Convenince*/
      return RegExp.replace(self, pattern, replacement: replacement)
   }
   func replace(_ pattern: String, options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive, replacer: RegExp.Replacer) -> String {
      return RegExp.replace(self, pattern: pattern, options: options, replacer: replacer)
   }
   func search(_ pattern: String) -> Int? {/*Convenince*/
      return RegExp.search(self, pattern: pattern)
   }
}
