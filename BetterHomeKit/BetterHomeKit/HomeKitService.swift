//
//  HomeKitService.swift
//  BetterHomeKit
//
//  Created by Andre Gatti on 1/5/15.
//  Copyright (c) 2015 Nlr. All rights reserved.
//

import UIKit
import HomeKit

let LAMP_ACCESSORY_1  = 3
let LAMP_ACCESSORY_2 = 1
let LAMP_ACCESSORY_3 = 2

let BULB_SERVICE = 1

let POWER_CHARACTERISTIC = 0
let BRIGHTNESS_CHARACTERISTIC = 3
let HUE_CHARACTERISTIC = 2
let SATURATION_CHARACTERISTIC = 4

class HomeKitService: NSObject, HMAccessoryDelegate {
	
	weak var homeManager:HMHomeManager?
	var service: HMService?
	var services = [HMService]()
	var accessory: HMAccessory?
	var accessories = [HMAccessory]()
	
	
	class var sharedInstance : HomeKitService {
		struct Static {
			static var onceToken : dispatch_once_t = 0
			static var instance : HomeKitService? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = HomeKitService()
		}
		return Static.instance!
	}
	
	// MARK: Common use functions
	
	func retrieveCharacteristics(lampId : Int) -> [AnyObject]! {
		
		var hardwareLampId = 0
		switch (lampId) {
		case 1:
			hardwareLampId = LAMP_ACCESSORY_1
			break
		case 2:
			hardwareLampId = LAMP_ACCESSORY_2
			break
		case 3:
			hardwareLampId = LAMP_ACCESSORY_3
			break
		default:
			println("Error getting hardware lamp id: \(lampId)")
		}
		
		let accessory = Core.sharedInstance.currentHome!.accessories[hardwareLampId] as HMAccessory
		
		service = accessory.services[BULB_SERVICE] as? HMService
		
		return service!.characteristics
	}
	
	func setCharacteristicValue(lampId : Int, object : HMCharacteristic, value : Int, reply: (([NSObject : AnyObject]!) -> Void)!) {
		
		var charDesc = object.characteristicType
		if let desc = HomeKitUUIDs[object.characteristicType] {
			charDesc = desc
			println("Writing characteristic: " + charDesc)
		}
		
		var result = 0
		var replyInfo = NSMutableDictionary()
		
		switch (object.metadata.format as NSString) {
		case HMCharacteristicMetadataFormatBool:
			
			object.writeValue((value == 0) ? false : true, completionHandler:
				{
					(error:NSError!) in
					if (error != nil) {
						NSLog("Change Char Error: \(error)")
						replyInfo.setValue("Error", forKey: "error")
						
						reply(replyInfo)
					} else {
						result = object.value as Int
						
						replyInfo.setValue(lampId, forKey: "device_id")
						replyInfo.setValue(result, forKey: "result")
						replyInfo.setValue("Boolean value written correctly", forKey: "comments")
						
						reply(replyInfo)
						
					}
				}
			)
		case HMCharacteristicMetadataFormatInt,HMCharacteristicMetadataFormatFloat,HMCharacteristicMetadataFormatUInt8,HMCharacteristicMetadataFormatUInt16,HMCharacteristicMetadataFormatUInt32,HMCharacteristicMetadataFormatUInt64:
			
			object.writeValue(value, completionHandler:
				{
					(error:NSError!) in
					if (error != nil) {
						NSLog("Change Char Error: \(error)")
						replyInfo.setValue("Error", forKey: "error")
						
						reply(replyInfo)
					} else {
						result = object.value as Int
						
						replyInfo.setValue(lampId, forKey: "device_id")
						replyInfo.setValue(result, forKey: "result")
						replyInfo.setValue("Integer value written correctly", forKey: "comments")
						
						reply(replyInfo)
						
					}
				}
			)
		default:
			NSLog("Unsupported")
		}
	}
	
	// MARK: Power functions
	
	func onLamp(lampId : Int, reply: (([NSObject : AnyObject]!) -> Void)!) {
		var characteristics = [HMCharacteristic]()
		var powerCharacteristic:HMCharacteristic?
		
		characteristics = self.retrieveCharacteristics(lampId) as [HMCharacteristic]
		
		for characteristic in characteristics as [HMCharacteristic] {
			if characteristic.characteristicType == (HMCharacteristicTypePowerState as String) {
				powerCharacteristic = characteristic
			}
		}
		
		self.setCharacteristicValue(lampId, object: powerCharacteristic!, value: 1, reply)
	}
	
	func offLamp(lampId : Int, reply: (([NSObject : AnyObject]!) -> Void)!) {
		var characteristics = [HMCharacteristic]()
		var powerCharacteristic:HMCharacteristic?
		
		characteristics = self.retrieveCharacteristics(lampId) as [HMCharacteristic]
		
		for characteristic in characteristics as [HMCharacteristic] {
			if characteristic.characteristicType == (HMCharacteristicTypePowerState as String) {
				powerCharacteristic = characteristic
			}
		}
		
		self.setCharacteristicValue(lampId, object: powerCharacteristic!, value: 0, reply)
	}
	
	// MARK: Hue functions (0 - 65535)
	
	func setHue(lampId : Int, value : Int, reply: (([NSObject : AnyObject]!) -> Void)!) {
		var characteristics = [HMCharacteristic]()
		var hueCharacteristic:HMCharacteristic?
		
		characteristics = self.retrieveCharacteristics(lampId) as [HMCharacteristic]
		
		for characteristic in characteristics as [HMCharacteristic] {
			if characteristic.characteristicType == (HMCharacteristicTypeHue as String) {
				hueCharacteristic = characteristic
			}
		}
		
		self.setCharacteristicValue(lampId, object: hueCharacteristic!, value: value, reply)
	}
	
	// MARK: Saturation functions (0 - 254)
	
	func setSaturation(lampId : Int, value : Int, reply: (([NSObject : AnyObject]!) -> Void)!) {
		var characteristics = [HMCharacteristic]()
		var saturationCharacteristic:HMCharacteristic?
		
		characteristics = self.retrieveCharacteristics(lampId) as [HMCharacteristic]
		
		for characteristic in characteristics as [HMCharacteristic] {
			if characteristic.characteristicType == (HMCharacteristicTypeSaturation as String) {
				saturationCharacteristic = characteristic
			}
		}
		
		self.setCharacteristicValue(lampId, object: saturationCharacteristic!, value: value, reply)
	}
	
	// MARK: Brightness functions (0 - 254)
	
	func setBrightness(lampId : Int, value : Int, reply: (([NSObject : AnyObject]!) -> Void)!) {
		var characteristics = [HMCharacteristic]()
		var brightnessCharacteristic:HMCharacteristic?
		
		characteristics = self.retrieveCharacteristics(lampId) as [HMCharacteristic]
		
		for characteristic in characteristics as [HMCharacteristic] {
			if characteristic.characteristicType == (HMCharacteristicTypeBrightness as String) {
				brightnessCharacteristic = characteristic
			}
		}
		
		self.setCharacteristicValue(lampId, object: brightnessCharacteristic!, value: value, reply)
	}
	
	// MARK: HMAccessoryDelegate functions
	
	func accessory(accessory: HMAccessory!, service: HMService!, didUpdateValueForCharacteristic characteristic: HMCharacteristic!)
	{
		NSLog("HOME SERVICE didUpdateValueForCharacteristic:\(characteristic)")
	}
	
	
}


