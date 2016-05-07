import Foundation

public extension NSDate {
    
    func stringByShortTimeFormat() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle;
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle;
        return dateFormatter.stringFromDate(self)
    }
}