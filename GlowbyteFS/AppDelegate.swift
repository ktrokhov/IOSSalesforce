//
//  AppDelegate.swift
//  GlowbyteFS
//
//  Created by Kirill on 29.11.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSDKCore
import GoogleMaps
import GooglePlaces
import SmartSync

var googleApiKey="API-KEY"

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?



    override
    init() {
        super.init()
        SalesforceManager.initializeSDK()
        AuthHelper.registerBlock(forCurrentUserChangeNotifications: { [weak self] in
            self?.resetViewState {
                self?.setupRootViewController()
            }
        })

    }

    // MARK: - App delegate lifecycle

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        SFPushNotificationManager.sharedInstance().registerForRemoteNotifications()

        //Uncomment the code below to see how you can customize the color, textcolor,
        //  font and fontsize of the navigation bar
        //var loginViewConfig = LoginViewControllerConfig()
        //Set showSettingsIcon to NO if you want to hide the settings icon on the nav bar
        //loginViewConfig.showSettingsIcon = false
        //Set showNavBar to NO if you want to hide the top bar
        //loginViewConfig.showNavbar = true
        //loginViewConfig.navBarColor = UIColor(red: 0.051, green: 0.765, blue: 0.733, alpha: 1.0)
        //loginViewConfig.navBarTextColor = UIColor.white
        //loginViewConfig.navBarFont = UIFont(name: "Helvetica", size: 16.0)
        //UserAccountManager.sharedInstance().loginViewControllerConfig = loginViewConfig
        AuthHelper.loginIfRequired { [weak self] in
            self?.setupRootViewController()
            //SmartStoreSDKManager.shared.setupUserStoreFromDefaultConfig()
            //SmartSyncSDKManager.shared.setupUserSyncsFromDefaultConfig()
        }
        
       //SmartStoreSDKManager.shared.setupUserStoreFromDefaultConfig()
       //SmartSyncSDKManager.shared.setupUserSyncsFromDefaultConfig()
        GMSServices.provideAPIKey(googleApiKey)
        GMSPlacesClient.provideAPIKey(googleApiKey)

        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        SFPushNotificationManager.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
        if UserAccountManager.shared.currentUserAccount?.credentials.accessToken != nil {
            SFPushNotificationManager.sharedInstance().registerSalesforceNotifications(completionBlock: nil, fail: nil)
        }
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error ) {
        // Respond to any push notification registration errors here.
    }

    // swiftlint:disable:next identifier_name
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return false
    }
    
    
    
    
    func setupRootViewController() {
        self.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController()
        self.window!.makeKeyAndVisible()
    }

    func resetViewState(_ postResetBlock: @escaping () -> Void) {
        if let rootViewController = self.window!.rootViewController {
            if rootViewController.presentedViewController != nil {
                rootViewController.dismiss(animated: false, completion: postResetBlock)
                return
            }
        }
        postResetBlock()
    }

}
