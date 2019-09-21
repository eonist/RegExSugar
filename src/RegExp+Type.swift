import Foundation

extension RegExp {
   public typealias Replacer = (_ match: String) -> String? // if nil is returned then replacer closure didn't want to replace the match
}
