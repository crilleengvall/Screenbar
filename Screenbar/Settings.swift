import Foundation

class Settings : NSObject {

    static var secondsKey = "seconds"
    
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
}