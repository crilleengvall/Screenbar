import Foundation

class ScreenShot : NSObject {
    
    func take() {
        let date = NSDate()
        let dateString = date.stringByShortTimeFormat().stringByReplacingOccurrencesOfString(":", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)        
        let task = NSTask()
        task.launchPath = "/usr/sbin/screencapture"
        task.arguments = [NSHomeDirectory() + "/Desktop/Screenshot-" + dateString + ".png"]
        task.launch()
    }
}