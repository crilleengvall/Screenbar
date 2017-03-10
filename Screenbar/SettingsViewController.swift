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
        self.errorMessage.isHidden = false
    }
    
    func hideError() {
        self.errorMessage.isHidden = true
    }
    
    func saveSettings(_ seconds: Double?, path: URL?) {
        Settings.setSecondsIntervall(seconds)
        Settings.setPath(path)
    }
    
    func setPath() {
        self.path.url = Settings.getPath() as URL
        self.path.allowedTypes = ["public.folder"]
    }
    
    func close() {
        let appDelegate : AppDelegate = NSApplication.shared().delegate as! AppDelegate
        appDelegate.hideSettings(self)
    }
}

extension SettingsViewController{
    
    @IBAction func saveSettings(_ sender: NSButton){
        let seconds: Double? = Double(self.secondsTextBox.stringValue)
        let path: URL? = self.path.url
        if(seconds == nil) {
            self.showError()
        }
        else {
            self.saveSettings(seconds, path: path)
            self.close()
        }
    }
}
