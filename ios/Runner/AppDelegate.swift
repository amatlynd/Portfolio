// import UIKit
// import Flutter

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }

import UIKit  
import Flutter  
import MarketingCloudSDK  
  
@UIApplicationMain  
@objc class AppDelegate: FlutterAppDelegate {  
    override func application(  
        _ application: UIApplication,  
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?  
    ) -> Bool {  
        GeneratedPluginRegistrant.register(with: self)  
        self.configureMarketingCloudSDK()  
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)  
    }  
      
    func configureMarketingCloudSDK() {  
        let builder = MarketingCloudSDKConfigBuilder()  
            .sfmc_setApplicationId("<your_application_id>")  
            .sfmc_setAccessToken("<your_access_token>")  
            .sfmc_setMarketingCloudServerUrl("<your_marketing_cloud_url>")  
            .sfmc_setMid("<your_mid>")  
            .sfmc_build()!  
          
        do {  
            try MarketingCloudSDK.sharedInstance().sfmc_configure(with:builder)  
            registerForRemoteNotification()  
        } catch let error as NSError {  
            
        }  
    }  
      
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {  
        MarketingCloudSDK.sharedInstance().sfmc_setDeviceToken(deviceToken)  
    }  
    func registerForRemoteNotification() {  
            if #available(iOS 10.0, *) {  
                let center  = UNUserNotificationCenter.current()  
  
                center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in  
 if error == nil{  
                        UIApplication.shared.registerForRemoteNotifications()  
                    }  
                }  
  
            }  
            else {  
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))  
                UIApplication.shared.registerForRemoteNotifications()  
            }  
        }  
      
    override func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {  
        if(MarketingCloudSDK.sharedInstance().sfmc_isReady() == false) {  
            self.configureMarketingCloudSDK()  
        }  
    }  
}
