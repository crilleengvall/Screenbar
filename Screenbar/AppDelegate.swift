import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let screenshotHandler = ScreenShot()
    var timer: NSTimer = NSTimer()
    let settingsPopover = NSPopover()
    var eventMonitor : EventMonitor?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.addMenu()
        self.addImage()
        self.initSettingsPopover()
        self.initEventMonitor()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
    func addMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Automatic screenshot", action: #selector(self.automaticScreenshot(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(NSMenuItem(title: "Settings...", action: #selector(self.showSettings), keyEquivalent: "S"))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(self.terminate), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    func addImage() {
        if let button = statusItem.button {
            button.image = NSImage(named: "ScreenbarIcon")
        }
    }
    
    func automaticScreenshot(sender: AnyObject) {
        if(self.timer.valid) {
            self.stopAutomaticScreenShot()
        }
        else {
            self.startAutomaticScreenshot()
        }
    }
    
    func startAutomaticScreenshot() {
        let seconds = Settings.getSecondsInterval()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(seconds!, target: screenshotHandler, selector: #selector(ScreenShot.take), userInfo: nil, repeats: true)
        self.ChangeTitleOfMenuItem("Stop automatic screenshot", index: 0)
    }
    
    func stopAutomaticScreenShot() {
        self.timer.invalidate()
        self.ChangeTitleOfMenuItem("Automatic screenshot", index: 0)
    }
    
    func initSettingsPopover() {
        settingsPopover.contentViewController = SettingsViewController(nibName: "SettingsView", bundle: nil)
    }
    
    func initEventMonitor() {
        eventMonitor = EventMonitor(mask: [.LeftMouseDownMask, .RightMouseDownMask]) { [unowned self] event in
            if self.settingsPopover.shown {
                self.hideSettings(event)
            }
        }
        eventMonitor?.start()
    }
    
    func showSettings() {
        if let button = statusItem.button {
            settingsPopover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
            eventMonitor?.start()
        }
    }
    
    func hideSettings(sender: AnyObject?) {
        settingsPopover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func ChangeTitleOfMenuItem(title:String, index:Int) {
        let item = statusItem.menu?.itemAtIndex(index)
        item?.title = title
    }
    
    func terminate() {
        exit(0)
    }
}

