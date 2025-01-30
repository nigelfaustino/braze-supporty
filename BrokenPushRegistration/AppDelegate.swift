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
    let configuration = Braze.Configuration(apiKey: "", endpoint: "")
    configuration.logger.level = .debug
    let braze = Braze(configuration: configuration)
    self.braze = braze
    
    application.registerForRemoteNotifications()
    let center = UNUserNotificationCenter.current()
    center.setNotificationCategories(Braze.Notifications.categories)
    center.delegate = self
    var options: UNAuthorizationOptions = [.alert, .sound, .badge]
    if #available(iOS 12.0, *) {
      options = UNAuthorizationOptions(rawValue: options.rawValue | UNAuthorizationOptions.provisional.rawValue)
    }
    center.requestAuthorization(options: options) { granted, error in
      print("Notification authorization, granted: \(granted), error: \(String(describing: error))")
    }

    return true
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
