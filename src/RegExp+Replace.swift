import Foundation

extension RegExp {
   /**
    * Replaces all matches with the replacment string
    * - Returns Value A string with matching regular expressions replaced by the template string.
    * - NOTE: you can use this call replaceMatchesInString to modify the original string, must use nsmutablestring to do this
    * - NOTE: ⚠️️ NSRegularExpression has lots of good info -> https://developer.apple.com/library/mac/documentation/Foundation/Reference/NSRegularExpression_Class/index.html
    * - IMPORTANT: ⚠️️ by using "$1" or "$2" etc you can replace with the match
    * - PARAM: string The string to search for values within.
    * - PARAM: options: The matching options to use. See NSMatchingOptions for possible values.
    * - PARAM: range: The range of the string to search.
    * - PARAM: replacement: The substitution template used when replacing matching instances.
    * - Fixme: ⚠️️ The PARAM: text should be inout, maybe?
    * ## Examples:
    * RegExp.replace("<strong>Hell</strong>o, <strong>Hell</strong>o, <strong>Hell</strong>o", "<\\/?strong>",  "*")//Output:  "*Hell*o, *Hell*o, *Hell*o"
    * RegExp.replace("yeah yeah","(\\b\\w+\\b)", "bla")//bla bla
    */
   public static func replace(_ str: String, _ pattern: String, replacement: String, options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive) -> String {
      do {
         let stringlength = str.count
         let regex = try NSRegularExpression(pattern: pattern, options: options)
         let modString = regex.stringByReplacingMatches(in: str, options: [], range: NSMakeRange(0, stringlength), withTemplate: replacement)
         return modString
      } catch let error as NSError {
         print("invalid regex: \(error.localizedDescription)")
         return ""
      }
   }
   
   /**
    * New, replaces with a closure
    * - Fixme: ⚠️️ Try to performance test if accumulative substring is faster (you += before the match + the match and so on)
    * ## Examples:
    * Swift.print("bad wolf, bad dog, Bad sheep".replace("\\b([bB]ad)\\b"){return $0.isLowerCased ? $0 : $0.lowercased()})
    */
   public static func replace(_ str: String, pattern: String, options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive, replacer: Replacer) -> String {
      //        Swift.print("RegExp.replace")
      var str = str
      RegExp.matches(str, pattern: pattern).reversed().forEach {
         let range: NSRange = $0.range(at: 1)
         //            Swift.print("range: " + "\(range)")
         let stringRange = str.index(str.startIndex, offsetBy: range.location)..<str.index(str.endIndex, offsetBy: range.length)
         //str.stringRange(str, range.location, len: range.length)
         let match: String = .init(str[stringRange])//substring(with: stringRange)//[stringRange.lowerBound..<stringRange.upperBound] //StringParser.subStr(str, range.location, range.length) // swift 4 upgrade, was: str.substring(with: stringRange) //Fixme: ⚠️️ reuse the stringRange to get the subrange here
         //            Swift.print("match: " + "\(match)")
         if let replacment: String = replacer(match) {
            str.replaceSubrange(stringRange, with: replacment)
         }
      }
      return str
   }
}
