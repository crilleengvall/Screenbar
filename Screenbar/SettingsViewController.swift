import Cocoa

class SettingsViewController: NSViewController {
    @IBOutlet var secondsTextBox: NSTextField!
    @IBOutlet var errorMessage: NSTextField!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.setSeconds()
        self.hideError()
    }
    
    func setSeconds() {
        let seconds: Double? = Settings.getSecondsInterval()
        self.secondsTextBox.stringValue = String(seconds!)
    }
    
    func showError() {
        self.errorMessage.hidden = false
    }
    
    func hideError() {
        self.errorMessage.hidden = true
    }
    
    func saveSettings(seconds: Double?) {
        Settings.setSecondsIntervall(seconds)
    }
    
    func close() {
        let appDelegate : AppDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.hideSettings(self)
    }
}

extension SettingsViewController{
    
    @IBAction func saveSeconds(sender: NSButton){
        let seconds: Double? = Double(self.secondsTextBox.stringValue)
        if(seconds == nil) {
            self.showError()
        }
        else {
            self.saveSettings(seconds)
            self.close()
        }
    }
}