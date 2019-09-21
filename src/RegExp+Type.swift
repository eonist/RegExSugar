import Foundation

extension RegExp {
   public typealias Replacer = (_ match: String) -> String? // if nil is returned then replacer closure didn't want to replace the match
   public typealias ReplacmentResult = [(range: Range<String.Index>, replacement: String)]
   public typealias Replace = (_ result: NSTextCheckingResult) -> ReplacmentResult? // if nil is returned then replacer closure didn't want to replace the match
}
