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
let LAMP_ACCESSORY_2 = 2
let LAMP_ACCESSORY_3 = 1

let BULB_SERVICE = 1

let POWER_CHARACTERISTIC = 0
let BRIGHTNESS_CHARACTERISTIC = 1
let HUE_CHARACTERISTIC = 2
let SATURATION_CHARACTERISTIC = 3

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
        
        var result = 0
        var replyInfo = NSMutableDictionary()
        
        switch (object.metadata.format as NSString) {
//        case HMCharacteristicMetadataFormatBool:
//            
//            // TODO TRANSFORM Value to string
//            object.writeValue(value, completionHandler:
//                {
//                    (error:NSError!) in
//                    if (error != nil) {
//                        NSLog("Change Char Error: \(error)")
//                        replyInfo.setValue("Error", forKey: "error")
//                        
//                        reply(replyInfo)
//                    } else {
//                        result = object.value as Int
//                        
//                        replyInfo.setValue(lampId, forKey: "device_id")
//                        replyInfo.setValue(result == 0 ? false : true, forKey: "result")
//                        replyInfo.setValue("Hola mundo", forKey: "comments")
//                        
//                        reply(replyInfo)
//                        
//                    }
//                }
//            )
        case HMCharacteristicMetadataFormatBool, HMCharacteristicMetadataFormatInt,HMCharacteristicMetadataFormatFloat,HMCharacteristicMetadataFormatUInt8,HMCharacteristicMetadataFormatUInt16,HMCharacteristicMetadataFormatUInt32,HMCharacteristicMetadataFormatUInt64:
//            let f = NSNumberFormatter()
//            f.numberStyle = NSNumberFormatterStyle.DecimalStyle
            
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
                        replyInfo.setValue("Value written correctly", forKey: "comments")
                        
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
        
        characteristics = self.retrieveCharacteristics(lampId) as [HMCharacteristic]
        
        var charDesc = characteristics[0].characteristicType
        if let desc = HomeKitUUIDs[characteristics[0].characteristicType] {
            charDesc = desc
        }

        self.setCharacteristicValue(lampId, object: characteristics[POWER_CHARACTERISTIC] as HMCharacteristic, value: 1, reply)
    }
    
    func offLamp(lampId : Int, reply: (([NSObject : AnyObject]!) -> Void)!) {
        println("OFF Lamp id: \(lampId)")
    }

    // MARK: Hue functions (0 - 65535)
    
    func setHue(lampId : Int, value : Int, reply: (([NSObject : AnyObject]!) -> Void)!) {
        var characteristics = [HMCharacteristic]()

        characteristics = self.retrieveCharacteristics(lampId) as [HMCharacteristic]
            
     //  characteristics =     char as [HMCharacteristic]
        
        // TODO Replace the value of value for a real value
        self.setCharacteristicValue(lampId, object: characteristics[HUE_CHARACTERISTIC] as HMCharacteristic, value: value, reply)
    }
    
    // MARK: Saturation functions (0 - 254)
    
    func setSaturation(lampId : Int, value : Int, reply: (([NSObject : AnyObject]!) -> Void)!) {
        var characteristics = [HMCharacteristic]()
        
        characteristics = self.retrieveCharacteristics(lampId) as [HMCharacteristic]
        
        // TODO Replace the value of value for a real value
        self.setCharacteristicValue(lampId, object: characteristics[SATURATION_CHARACTERISTIC] as HMCharacteristic, value: value, reply)
    }
    
    // MARK: Brightness functions (0 - 254)
    
    func setBrightness(lampId : Int, value : Int, reply: (([NSObject : AnyObject]!) -> Void)!) {
        var characteristics = [HMCharacteristic]()
        
        characteristics = self.retrieveCharacteristics(lampId) as [HMCharacteristic]
        
        // TODO Replace the value of value for a real value
        self.setCharacteristicValue(lampId, object: characteristics[BRIGHTNESS_CHARACTERISTIC] as HMCharacteristic, value: value, reply)
    }

    // MARK: HMAccessoryDelegate functions
    
    func accessory(accessory: HMAccessory!, service: HMService!, didUpdateValueForCharacteristic characteristic: HMCharacteristic!)
    {
        NSLog("HOME SERVICE didUpdateValueForCharacteristic:\(characteristic)")
    }
    
    
}

