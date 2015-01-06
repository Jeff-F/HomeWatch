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
		var operation = "on"
		if (lamp.getState()) {
			operation = "off"
		}
		userInfo.setValue(operation, forKey: "operation")
		userInfo.setValue(lamp.getId(), forKey: "device_id")
		if (WKInterfaceController.openParentApplication(userInfo,
			reply: {(replyInfo, error) -> () in
				if ((error) != nil) {
					println("Error trying to communicate with parent app - 1002")
                    println(error)

				} else {
					if (replyInfo != nil) {
						var reply = replyInfo as NSDictionary
						var lampId = reply.valueForKey("device_id") as Int
						var state = reply.valueForKey("device_state") as Bool
                        var comments = reply.valueForKey("comments") as String

                        println(comments)
						if (lamp.getId() != 3) {
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
	
	func setHue(lamp : Lamp, value : Float) {
		self.setCharacteristic("hue", forLamp: lamp, withValue: value)
	}
	
	func setBrightness(lamp : Lamp, value : Float) {
		self.setCharacteristic("brightness", forLamp: lamp, withValue: value)
	}
	
	func setSaturation(lamp : Lamp, value : Float) {
		self.setCharacteristic("saturation", forLamp: lamp, withValue: value)
	}
	
	func setCharacteristic(characteristic : String, forLamp lamp : Lamp, withValue value : Float) {
		var userInfo = NSMutableDictionary()
		userInfo.setValue(characteristic, forKey: "operation")
		userInfo.setValue(lamp.getId(), forKey: "device_id")
		userInfo.setValue(Int(value), forKey: "value")
		if (WKInterfaceController.openParentApplication(userInfo,
			reply: {(replyInfo, error) -> () in
				if ((error) != nil) {
					println("Error trying to communicate with parent app - 1002")
					println(error)
					
				} else {
					if (replyInfo != nil) {
						var reply = replyInfo as NSDictionary
						var lampId = reply.valueForKey("device_id") as Int
						var characteristic = reply.valueForKey("characteristic") as Bool
						var value = reply.valueForKey("value") as String
						println("Device \(lampId); characteristic: \(characteristic); value: \(value)")
					}
				}
		})) {
			println("Successful communication with parent app - 1000")
		} else {
			println("Error trying to communicate with parent app - 1001")
		}
	}
	
}