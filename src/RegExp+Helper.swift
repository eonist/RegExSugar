import Foundation
/**
 * Helper
 */
extension RegExp {
   /*
    * Extracts associated capture groups from the RegExp.matches result
    * - Fixme: ⚠️️ Would be great if .rawValue was done inside this method, can be done with <T> possibly look at the apple docs about enumerations
    * ## EXAMPLES:
    * RegExp.value(fullString,match,StatusParts.second.rawValue)
    * - Fixme: ⚠️️ you should check if there is content in the range first, if ther eis not return nilor error
    */
   public static func value(_ str: String, result: NSTextCheckingResult, key: Int) -> String {
      return (str as NSString).substring(with: result.range(at: key))
   }
   /**
    * Finds first index of pattern in string
    */
   public static func search(_ input: String, pattern: String, options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive) -> Int? {
      guard let range = input.range(of: pattern, options: .regularExpression) else { return nil }
      return input.distance(from: input.startIndex, to: range.lowerBound)
   }
}
/**
 * NSTextCheckingResult
 */
extension NSTextCheckingResult {
   /**
    * value for key
    */
   public func value(_ str: String, key: Int) -> String { // Convenience
      return RegExp.value(str, result: self, key: key)
   }
}
