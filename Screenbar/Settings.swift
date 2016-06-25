import Foundation

class Settings : NSObject {

    static var secondsKey = "seconds"
    static var pathKey = "savePath"
    
    static func setSecondsIntervall(seconds: Double?) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(seconds!, forKey: secondsKey)
    }
    
    static func getSecondsInterval() -> Double? {
        let defaults = NSUserDefaults.standardUserDefaults()
        var seconds: Double? = defaults.doubleForKey(secondsKey)
        if(seconds == nil) {
            seconds = 1.0
        }
        return seconds
    }
    
    static func setPath(path: NSURL?) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setURL(path, forKey: pathKey)
    }
    
    static func getPath() -> NSURL {
        let defaults = NSUserDefaults.standardUserDefaults()
        var path : NSURL? = defaults.URLForKey(pathKey)
        if(path == nil) {
            path = NSURL(string: NSHomeDirectory() + "/Desktop/")
        }
        return path!
    }
}