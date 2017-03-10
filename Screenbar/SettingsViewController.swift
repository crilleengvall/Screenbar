import Cocoa

class SettingsViewController: NSViewController {
    @IBOutlet weak var secondsTextBox: NSTextField!
    @IBOutlet weak var errorMessage: NSTextField!
    @IBOutlet weak var path: NSPathControl!
    @IBOutlet weak var playSound: NSButton!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.setSeconds()
        self.hideError()
        self.setPath()
        self.setPlaySound()
    }
    
    func setSeconds() {
        let seconds: Double? = Settings.getSecondsInterval()
        self.secondsTextBox.stringValue = String(seconds!)
    }
    
    func setPlaySound() {
        self.playSound.state = Settings.getPlaySound()
    }
    
    func showError() {
        self.errorMessage.isHidden = false
    }
    
    func hideError() {
        self.errorMessage.isHidden = true
    }
    
    func saveSettings(_ seconds: Double?, path: URL?, playSound: Int) {
        Settings.setSecondsIntervall(seconds)
        Settings.setPath(path)
        Settings.setPlaySound(playSound)
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
        let playSound = self.playSound.state
        if(seconds == nil) {
            self.showError()
        }
        else {
            self.saveSettings(seconds, path: path, playSound: playSound)
            self.close()
        }
    }
}
