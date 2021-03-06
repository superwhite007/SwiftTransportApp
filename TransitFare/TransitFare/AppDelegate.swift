//
//  AppDelegate.swift
//  TransitFare
//
//  Created by ajaybeniwal203 on 18/1/16.
//  Copyright © 2016 ajaybeniwal203. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var deviceToken :String?
    var tabViewController :UITabBarController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        let textAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().tintColor =  UIColor.whiteColor()
        UINavigationBar.appearance().barTintColor = UIColor.transitFareNavigationBarColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        
        //Adding Categories for push Notifications
        
        let purchasePassType = UIMutableUserNotificationAction()
        purchasePassType.identifier = ActionCategory.Purchase.rawValue
        purchasePassType.title = "Purchase Pass"
        purchasePassType.activationMode = .Foreground
        purchasePassType.destructive = false
        
        let cancelPurchasePassType = UIMutableUserNotificationAction()
        cancelPurchasePassType.identifier = ActionCategory.Cancel.rawValue
        cancelPurchasePassType.title = "Cancel"
        cancelPurchasePassType.activationMode = .Background
        cancelPurchasePassType.destructive = true
        
        
        let passCategory = UIMutableUserNotificationCategory()
        passCategory.identifier = "PURCHASE_PASS_CATEGORY"
        passCategory.setActions([purchasePassType,cancelPurchasePassType], forContext:.Default)
        let categorySets:Set<UIUserNotificationCategory> = [passCategory];
        // End Categories
        let types = UIUserNotificationSettings(forTypes: [.Alert, .Badge],categories:categorySets)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(types)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        if let notificationPayLoad = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
            let orderId = notificationPayLoad["orderId"] as? NSString
            print(orderId);
        }
        
        
        /* Setting the login controller as root view controler */
        let parseConfiguration = ParseClientConfiguration {
            $0.applicationId = "myAppId"
            $0.clientKey = "myAppId"
            $0.server = "https://swifttransportapp.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(parseConfiguration)
        let currentUser = PFUser.currentUser()
        if currentUser == nil {
            self.window?.rootViewController = LoginViewController()
        }
            
        else{
            
            if let notificationPayload = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
                if let _: String = notificationPayload["orderId"] as? String {
                    let tabBar :UITabBarController = self.window?.rootViewController as! UITabBarController;
                    tabBar.redirectToSavedCardsView()
                }
            }
            
        }
        
        
        return true
    }
    
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var deviceTokenChanged: String = deviceToken.description
        deviceTokenChanged = deviceTokenChanged.stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("<", withString: "").stringByReplacingOccurrencesOfString(">", withString: "");
        self.deviceToken = deviceTokenChanged
        NSLog("Push Plugin register success: %@", self.deviceToken!);
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("failed to register for remote notifications:  (error)")
    }
    
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        if(TransitFareClient.sharedInstance.IsLoggedIn()){
            if(identifier==ActionCategory.Purchase.rawValue){
                if let _: String = userInfo["orderId"] as? String {
                    let tabBar :UITabBarController = self.window?.rootViewController as! UITabBarController;
                    tabBar.redirectToSavedCardsView()
                    completionHandler()
                }
            }
            else{
                print("clicked on cancel")
            }
            
        }
        else{
            self.window?.rootViewController = LoginViewController()
        }
        
        completionHandler()
        
        
    }
    
    // Handling click of push notification
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            if let aps = userInfo["aps"] as? [String: AnyObject]{
                // This means it is a silent notification and data will be download in background
                
                if let _ = aps["content-available"]{
                    print("download in the background")
                }
                
                
            }
            else{
                if(application.applicationState == .Inactive){
                    if let _: String = userInfo["orderId"] as? String {
                        let tabBar :UITabBarController = self.window?.rootViewController as! UITabBarController;
                        tabBar.redirectToSavedCardsView()
                    }
                }
            }
            
            completionHandler(UIBackgroundFetchResult.NewData)
        }
        else{
            completionHandler(UIBackgroundFetchResult.Failed)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
    }
    
    func applicationWillTerminate(application: UIApplication) {
        
    }
    
    
}

