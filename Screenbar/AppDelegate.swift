import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    let settingsPopover = NSPopover()
    var eventMonitor : EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.addImage()
        self.initSettingsPopover()
        self.initEventMonitor()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    func addImage() {
        if let button = statusItem.button {
            button.image = NSImage(named: "ScreenbarIcon")
            button.action = #selector(self.showSettings)
        }
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
    
    func terminate() {
        exit(0)
    }
}

