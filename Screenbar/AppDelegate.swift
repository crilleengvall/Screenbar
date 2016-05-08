import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let screenshotHandler = ScreenShot()
    var timer: NSTimer = NSTimer()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.addMenu()
        self.addImage()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
    func addMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Automatic screenshot", action: #selector(self.AutomaticScreenshot(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(self.terminate), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    func addImage() {
        if let button = statusItem.button {
            button.image = NSImage(named: "ScreenbarIcon")
        }
    }
    
    func AutomaticScreenshot(sender: AnyObject) {
        if(self.timer.valid) {
            self.timer.invalidate()
            self.ChangeTitleOfMenuItem("Automatic screenshot", index: 0)
        }
        else {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: screenshotHandler, selector: #selector(ScreenShot.take), userInfo: nil, repeats: true)
            self.ChangeTitleOfMenuItem("Stop automatic screenshot", index: 0)
        }
    }
    
    func ChangeTitleOfMenuItem(title:String, index:Int) {
        let item = statusItem.menu?.itemAtIndex(index)
        item?.title = title
    }
    
    func terminate() {
        exit(0)
    }
}

