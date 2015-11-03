/*
Channelade starter app for Apple TV
To get this app working for your channel, 
make sure to do the following: 
- Add your Channelade account key below
- Change the bundle identifier 
- Add your own artwork (icons and shelf image)
*/

import UIKit
import TVMLKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TVApplicationControllerDelegate {
    // MARK: Properties
    
    ///////////////////////////////////////////////////////
    // Edit the following line with 
    // Your Channelade account key
    ///////////////////////////////////////////////////////
    static let TVAccountKey = "PUT YOUR ACCOUNT KEY HERE" 
    ///////////////////////////////////////////////////////
    // That's it! Don't edit anything else below 
    ///////////////////////////////////////////////////////

    static let TVBaseURL = "https://tvos.channelade.com/"
    static let TVBootURL = "\(AppDelegate.TVBaseURL)tvos/\(AppDelegate.TVAccountKey)/application.js"

    var window: UIWindow?
    var appController: TVApplicationController?
    
    // MARK: UIApplication Overrides
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        /*
        Create the TVApplicationControllerContext for this application
        and set the properties that will be passed to the `App.onLaunch` function
        in JavaScript.
        */
        let appControllerContext = TVApplicationControllerContext()
        
        /*
        The JavaScript URL is used to create the JavaScript context for your
        TVMLKit application. Although it is possible to separate your JavaScript
        into separate files, to help reduce the launch time of your application
        we recommend creating minified and compressed version of this resource.
        This will allow for the resource to be retrieved and UI presented to
        the user quickly.
        */
        if let javaScriptURL = NSURL(string: AppDelegate.TVBootURL) {
            appControllerContext.javaScriptApplicationURL = javaScriptURL
        }
        
        appControllerContext.launchOptions["BASEURL"] = AppDelegate.TVBaseURL
        
        if let launchOptions = launchOptions as? [String: AnyObject] {
            for (kind, value) in launchOptions {
                appControllerContext.launchOptions[kind] = value
            }
        }
        
        appController = TVApplicationController(context: appControllerContext, window: window, delegate: self)
        
        return true
    }
    
    // MARK: TVApplicationControllerDelegate
    
    func appController(appController: TVApplicationController, didFinishLaunchingWithOptions options: [String: AnyObject]?) {
        print("\(__FUNCTION__) invoked with options: \(options)")
    }
    
    func appController(appController: TVApplicationController, didFailWithError error: NSError) {
        print("\(__FUNCTION__) invoked with error: \(error)")
        
        let title = "Error Launching Application"
        let message = error.localizedDescription
        let alertController = UIAlertController(title: title, message: message, preferredStyle:.Alert )
        
        self.appController?.navigationController.presentViewController(alertController, animated: true, completion: { () -> Void in
            // ...
        })
    }
    
    func appController(appController: TVApplicationController, didStopWithOptions options: [String: AnyObject]?) {
        print("\(__FUNCTION__) invoked with options: \(options)")
    }
}