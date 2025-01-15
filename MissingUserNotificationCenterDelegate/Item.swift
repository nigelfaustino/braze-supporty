//
//  Item.swift
//  MissingUserNotificationCenterDelegate
//
//  Created by Nigel Faustino on 1/14/25.
//

import Foundation
import SwiftData

@available(iOS 17, *)
@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
