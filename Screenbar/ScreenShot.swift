import Foundation

class ScreenShot : NSObject {
    
    lazy var dateFormatter = DateFormatter();
    
    func take() {
        let dateString = self.getDate()
        let task = Process()
        task.launchPath = "/usr/sbin/screencapture"
        var arguments = [String]();
        if(Settings.getPlaySound() == 0) {
            arguments.append("-x")
        }
        arguments.append(Settings.getPath().path + "/Screenshot-" + dateString + ".png")
        task.arguments = arguments
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
