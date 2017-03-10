import Foundation

class ScreenShot : NSObject {
    
    lazy var dateFormatter = DateFormatter();
    
    func take() {
        let dateString = self.getDate()
        let task = Process()
        task.launchPath = "/usr/sbin/screencapture"
        task.arguments = [Settings.getPath().path + "/Screenshot-" + dateString + ".png"]
        task.launch()
    }
    
    private func getDate() -> String {
        let date = Date()
        self.dateFormatter.dateStyle = DateFormatter.Style.none
        self.dateFormatter.timeStyle = DateFormatter.Style.medium
        var dateString = self.dateFormatter.string(from: date)
        dateString = dateString.replacingOccurrences(of: ":", with: ".", options: NSString.CompareOptions.literal, range: nil)
        return dateString;
    }
}
