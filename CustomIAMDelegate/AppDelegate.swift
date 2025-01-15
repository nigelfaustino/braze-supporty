//
//  AppDelegate.swift
//  Supporty
//
//  Created by Nigel Faustino on 1/15/25.
//

import UIKit
import BrazeKit
import BrazeUI

class AppDelegate: NSObject, UIApplicationDelegate, BrazeInAppMessageUIDelegate {
  var braze: Braze? = nil
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    var configuration = Braze.Configuration(apiKey: "4aafcb05-514a-47ce-9beb-e56995d8b40d", endpoint: "sondheim.braze.com")
    // Not required for IAM, but added for ease of test sends
    configuration.push.automation = true
    
    configuration.logger.level = .debug
    self.braze = Braze(configuration: configuration)
    
    let presenter = BrazeInAppMessageUI()
    presenter.delegate = self
    self.braze?.inAppMessagePresenter = presenter
    return true
  }
  
  
// This method gets called before the IAM is attempted to display. Customers will tend to customize here if there are certain screens or times they don't want to show an IAM.
  func inAppMessage(_ ui: BrazeInAppMessageUI, displayChoiceForMessage message: Braze.InAppMessage) -> BrazeInAppMessageUI.DisplayChoice {
    return .discard
  }
}
