import Foundation

public extension NSDate {
    
    private var dateFormatter: NSDateFormatter? {
        get {
            var formatter = objc_getAssociatedObject(self, "NSharpDateSwiftFormatter") as? NSDateFormatter
            if(formatter == nil) {
                formatter = NSDateFormatter()
                objc_setAssociatedObject(self, "NSharpDateSwiftFormatter", formatter as NSDateFormatter?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
            return formatter;
        }
    }
    
    var day : Int {
        self.dateFormatter?.dateFormat = "dd"
        let day = self.dateFormatter?.stringFromDate(self)
        return Int(day!)!
    }
    
    var dayOfWeek : String {
        self.dateFormatter?.dateFormat = "EEEE"
        return (self.dateFormatter?.stringFromDate(self))!
    }
    
    var dayOfYear : Int {
        let calendar = NSCalendar.currentCalendar()
        let dayOfYear = calendar.ordinalityOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Year, forDate: self)
        return dayOfYear
    }
    
    // MARK: - Methods
    
    func toStringByShortTimeFormat() -> String {
        self.dateFormatter!.dateStyle = NSDateFormatterStyle.NoStyle
        self.dateFormatter!.timeStyle = NSDateFormatterStyle.MediumStyle
        return self.dateFormatter!.stringFromDate(self)
    }
}