import Foundation

extension RegExp {
   public typealias Replacer = (_ match: String) -> String? // if nil is returned then replacer closure didnt want to replace the match
}
