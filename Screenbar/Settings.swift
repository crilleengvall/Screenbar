import Foundation

class Settings : NSObject {

    static func setSecondsIntervall(seconds: Double?) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(seconds!, forKey: "seconds")
    }
    
    static func getSecondsInterval() -> Double? {
        let defaults = NSUserDefaults.standardUserDefaults()
        var seconds: Double? = defaults.doubleForKey("seconds")
        if(seconds == nil) {
            seconds = 1.0
        }
        return seconds
    }
}