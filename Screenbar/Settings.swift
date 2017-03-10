import Foundation

class Settings : NSObject {

    static var secondsKey = "seconds"
    static var pathKey = "savePath"
    static var playSoundKey = "playSound"
    
    static func setSecondsIntervall(_ seconds: Double?) {
        let defaults = UserDefaults.standard
        defaults.set(seconds!, forKey: secondsKey)
    }
    
    static func getSecondsInterval() -> Double? {
        let defaults = UserDefaults.standard
        var seconds: Double? = defaults.double(forKey: secondsKey)
        if(seconds == nil) {
            seconds = 1.0
        }
        return seconds
    }
    
    static func setPath(_ path: URL?) {
        let defaults = UserDefaults.standard
        defaults.set(path, forKey: pathKey)
    }
    
    static func getPath() -> URL {
        let defaults = UserDefaults.standard
        var path : URL? = defaults.url(forKey: pathKey)
        if(path == nil) {
            path = URL(string: NSHomeDirectory() + "/Desktop/")
        }
        return path!
    }
    
    static func setPlaySound(_ state: Int?) {
        let defaults = UserDefaults.standard
        defaults.set(state, forKey: playSoundKey)
    }
    
    static func getPlaySound() -> Int {
        let defaults = UserDefaults.standard
        var state : Int? = defaults.integer(forKey: playSoundKey)
        if(state == nil) {
            state = 0;
        }
        return state!;
    }
}
