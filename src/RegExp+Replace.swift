import Foundation

extension RegExp {
   /**
    * Replaces all matches with the replacment string
    * - Returns Value A string with matching regular expressions replaced by the template string.
    * - Note: you can use this call replaceMatchesInString to modify the original string, must use nsmutablestring to do this
    * - Note: ⚠️️ NSRegularExpression has lots of good info -> https://developer.apple.com/library/mac/documentation/Foundation/Reference/NSRegularExpression_Class/index.html
    * - Important: ⚠️️ by using "$1" or "$2" etc you can replace with the match
    * - Parameter string The string to search for values within.
    * - Parameter options: The matching options to use. See NSMatchingOptions for possible values.
    * - Parameter range: The range of the string to search.
    * - Parameter replacement: The substitution template used when replacing matching instances.
    * - Fixme: ⚠️️ The PARAM: text should be inout, maybe?
    * ## Examples:
    * RegExp.replace("<strong>Hell</strong>o, <strong>Hell</strong>o, <strong>Hell</strong>o", "<\\/?strong>",  "*")//Output:  "*Hell*o, *Hell*o, *Hell*o"
    * RegExp.replace("yeah yeah","(\\b\\w+\\b)", "bla")//bla bla
    */
   public static func replace(_ str: String, pattern: String, replacement: String, options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive) -> String {
      do {
         let stringlength: Int = str.count
         let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: options)
         let range: NSRange = NSMakeRange(0, stringlength)
         let modString: String = regex.stringByReplacingMatches(in: str, options: [], range: range, withTemplate: replacement)
         return modString
      } catch let error as NSError {
         print("invalid regex: \(error.localizedDescription)")
         return "" // fixme ⚠️️ return nil
      }
   }
   /**
    * Loops over every string-segment that match the pattern and replaces with a closure (uses String in the closure)
    * - Fixme: ⚠️️ Try to performance test if accumulative substring is faster (you += before the match + the match and so on)
    * - Parameter replacer: (String)
    * ## Examples:
    * let str: String = "bad wolf, bad dog, Bad sheep"
    * let pattern: String = "\\b([bB]ad)\\b"
    * let result: String = str.replace(pattern) { $0.isLowerCased ? $0 : $0.lowercased() } // converts all "Bad" words to lowercase
    * Swift.print(result) // bad wolf, bad dog, bad sheep
    */
   public static func replace(_ str: String, pattern: String, options: NSRegularExpression.Options = .caseInsensitive, replacer: Replacer) -> String {
      var str = str
      RegExp.matches(str, pattern: pattern).reversed().forEach { nsCheckingResult in
         let range: NSRange = nsCheckingResult.range(at: 1) // The first result is the entire match and 1 is the actual precice match, I think
         let stringRange: Range<String.Index> = RegExp.stringRange(str: str, range: range)
         let match: String = .init(str[stringRange]) // Fixme: ⚠️️ Might want to assert if the range exists in the array?
         guard let replacment: String = replacer(match) else { Swift.print("RegExp.replace() ⚠️️ something wrong ⚠️️ "); return }
         str.replaceSubrange(stringRange, with: replacment)
      }
      return str
   }
   /**
    * Loops over every string-segment that match the pattern and replaces with a closure (uses Range in the closure)
    * - Parameter replace: (Range)
    * ## Examples:
    * let theResult: String = "".replace(pattern:"") { result in
    *    let beginning = result.stringRange(str, key: 1) // Capturing group 1
    *    let middle = result.stringRange(str, key: 2) // Capturing group 2
    *    let end = result.stringRange(str, key: 3) // Capturing group 3
    *    let newMiddleStr: String = {
    *         let middleStr: String = .init(str[middle])
    *         let pattern = "$(\\*)"
    *         return middleStr.replace(pattern) { "///" }
    *    }()
    *    return [(begining, "///"), (middle, newMiddleStr), (end, "///")]
    * }
    */
   public static func replace(str: String, pattern: String, options: NSRegularExpression.Options = .caseInsensitive, replace: Replace) -> String {
      var str = str
      RegExp.matches(str, pattern: pattern).reversed().forEach { nsCheckingResult in
         guard let replacementResult: ReplacmentResult = replace(nsCheckingResult) else { Swift.print("RegExp.replace() ⚠️️ something wrong ⚠️️ "); return }
         replacementResult.reversed().forEach {
            str.replaceSubrange($0.range, with: $0.replacement)
         }
      }
      return str
   }
}
