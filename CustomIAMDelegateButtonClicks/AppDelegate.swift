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
  
  
  // This method gets called whenever the SDK tries to process a click (either from the button or the body).
  func inAppMessage(_ ui: BrazeInAppMessageUI, shouldProcess clickAction: Braze.InAppMessage.ClickAction, buttonId: String?, message: Braze.InAppMessage, view: any InAppMessageView) -> Bool {
    return false
  }
  
}
