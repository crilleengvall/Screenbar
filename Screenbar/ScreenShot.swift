import Foundation

class ScreenShot : NSObject {
    
    func take() {
        let date = NSDate()
        let dateString = date.toStringByShortTimeFormat().stringByReplacingOccurrencesOfString(":", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let task = NSTask()
        task.launchPath = "/usr/sbin/screencapture"
        task.arguments = [Settings.getPath().path! + "/Screenshot-" + dateString + ".png"]
        task.launch()
    }
}