import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    let mainWindowPopover = NSPopover()
    var eventMonitor : EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.addImage()
        self.initMainWindowPopover()
        self.initEventMonitor()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    func addImage() {
        if let button = statusItem.button {
            button.image = NSImage(named: "ScreenbarIcon")
            button.action = #selector(self.showMainWindow)
        }
    }
    
    func initMainWindowPopover() {
        self.mainWindowPopover.contentViewController = MainWindowViewController(nibName: "MainWindowView", bundle: nil)
    }
    
    func initEventMonitor() {
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [unowned self] event in
            if self.mainWindowPopover.isShown {
                self.hideMainWindow(event)
            }
        }
        eventMonitor?.start()
    }
    
    func showMainWindow() {
        if let button = statusItem.button {
            self.mainWindowPopover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            eventMonitor?.start()
        }
    }
    
    func hideMainWindow(_ sender: AnyObject?) {
        self.mainWindowPopover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func terminate() {
        exit(0)
    }
}

