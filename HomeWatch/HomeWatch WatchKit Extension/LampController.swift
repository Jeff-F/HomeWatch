//
//  LampController.swift
//  HomeWatch
//
//  Created by Ecil Teodoro on 12/29/14.
//  Copyright (c) 2014 ArcTouch. All rights reserved.
//

import Foundation
import WatchKit

class LampController {
	
	func switchLampState(lamp : Lamp, updateLampStates : () -> ()) {
		var userInfo = NSMutableDictionary()
		userInfo.setValue("switch", forKey: "operation")
		userInfo.setValue(lamp.getId(), forKey: "device_id")
		if (WKInterfaceController.openParentApplication(userInfo,
			reply: {(replyInfo, error) -> () in
				if ((error) != nil) {
					println("Error trying to communicate with parent app - 1002")
				} else {
					if (replyInfo != nil) {
						var reply = replyInfo as NSDictionary
						var lampId = reply.valueForKey("device_id") as Int
						var state = reply.valueForKey("device_state") as Bool
						if (lamp.getId() != lampId) {
							println("Device ID does not match")
						} else {
							if (lamp.getState() != state) {
								lamp.switchState()
							}
							updateLampStates()
						}
					}
				}
		})) {
			println("Successful communication with parent app - 1000")
		} else {
			println("Error trying to communicate with parent app - 1001")
		}
	}
	
	func getLampState(lamp : Lamp) {
		lamp.getState()
	}
	
}