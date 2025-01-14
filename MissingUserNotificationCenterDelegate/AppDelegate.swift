//
//  AppDelegate.swift
//  Supporty
//
//  Created by Nigel Faustino on 1/14/25.
//


//
//  AppDelegate.swift
//  Supporty
//
//  Created by Nigel Faustino on 1/7/25.
//

import UIKit
import BrazeKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  var braze: Braze? = nil
    
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    let configuration = Braze.Configuration(apiKey: "e5ea2273-dd8e-4213-8185-060d6125da35", endpoint: "sondheim.braze.com")
    configuration.logger.level = .debug
    let braze = Braze(configuration: configuration)
    self.braze = braze
    
    application.registerForRemoteNotifications()
    return true
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    self.braze?.notifications.register(deviceToken: deviceToken)
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    if let braze = self.braze, braze.notifications.handleBackgroundNotification(
      userInfo: userInfo,
      fetchCompletionHandler: completionHandler
    ) {
      return
    }
    completionHandler(.noData)
  }
  
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void ) {
    if let braze = self.braze, braze.notifications.handleUserNotification(
      response: response,
      withCompletionHandler: completionHandler
    ) {
      return
    }
    completionHandler()

  }
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    if let braze = self.braze {
      braze.notifications.handleForegroundNotification(notification: notification)
    }

    if #available(iOS 14, *) {
      completionHandler([.list, .banner])
    } else {
      completionHandler(.alert)
    }
  }

}
