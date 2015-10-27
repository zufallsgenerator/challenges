import Foundation
extension NSString {
    func sha1() -> NSString {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joinWithSeparator("")
    }
}
var i = 0
let prefix : NSString = "c0ffee"
while true {
    let s = String(format:"example+%iexample.com", i)
    let h : NSString = s.sha1()
    if (h.substringToIndex(prefix.length) == prefix) {
        NSLog("%@ : %@", s, h)
        break
    }
    i++
}