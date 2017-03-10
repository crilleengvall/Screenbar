import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    let screenshotHandler = ScreenShot()
    var timer: Timer = Timer()
    let settingsPopover = NSPopover()
    var eventMonitor : EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.addMenu()
        self.addImage()
        self.initSettingsPopover()
        self.initEventMonitor()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    func addMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Automatic screenshot", action: #selector(self.automaticScreenshot(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Settings...", action: #selector(self.showSettings), keyEquivalent: "S"))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(self.terminate), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    func addImage() {
        if let button = statusItem.button {
            button.image = NSImage(named: "ScreenbarIcon")
        }
    }
    
    func automaticScreenshot(_ sender: AnyObject) {
        if(self.timer.isValid) {
            self.stopAutomaticScreenShot()
        }
        else {
            self.startAutomaticScreenshot()
        }
    }
    
    func startAutomaticScreenshot() {
        let seconds = Settings.getSecondsInterval()
        self.timer = Timer.scheduledTimer(timeInterval: seconds!, target: screenshotHandler, selector: #selector(ScreenShot.take), userInfo: nil, repeats: true)
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
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [unowned self] event in
            if self.settingsPopover.isShown {
                self.hideSettings(event)
            }
        }
        eventMonitor?.start()
    }
    
    func showSettings() {
        if let button = statusItem.button {
            settingsPopover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            eventMonitor?.start()
        }
    }
    
    func hideSettings(_ sender: AnyObject?) {
        settingsPopover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func ChangeTitleOfMenuItem(_ title:String, index:Int) {
        let item = statusItem.menu?.item(at: index)
        item?.title = title
    }
    
    func terminate() {
        exit(0)
    }
}

