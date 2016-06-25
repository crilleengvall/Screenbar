import Cocoa

class SettingsViewController: NSViewController {
    @IBOutlet weak var secondsTextBox: NSTextField!
    @IBOutlet weak var errorMessage: NSTextField!
    @IBOutlet weak var path: NSPathControl!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.setSeconds()
        self.hideError()
        self.setPath()
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
    
    func saveSettings(seconds: Double?, path: NSURL?) {
        Settings.setSecondsIntervall(seconds)
        Settings.setPath(path)
    }
    
    func setPath() {
        self.path.URL = Settings.getPath()
        self.path.allowedTypes = ["public.folder"]
    }
    
    func close() {
        let appDelegate : AppDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.hideSettings(self)
    }
}

extension SettingsViewController{
    
    @IBAction func saveSettings(sender: NSButton){
        let seconds: Double? = Double(self.secondsTextBox.stringValue)
        let path: NSURL? = self.path.URL
        if(seconds == nil) {
            self.showError()
        }
        else {
            self.saveSettings(seconds, path: path)
            self.close()
        }
    }
}