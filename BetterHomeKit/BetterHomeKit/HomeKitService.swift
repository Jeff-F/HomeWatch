//
//  HomeKitService.swift
//  BetterHomeKit
//
//  Created by Andre Gatti on 1/5/15.
//  Copyright (c) 2015 Nlr. All rights reserved.
//

import UIKit
import HomeKit

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
    
    
    
    
    func onLamp(lampId : Int, reply: (([NSObject : AnyObject]!) -> Void)!) {
        var characteristics = [HMCharacteristic]()


        
        println("ON Lamp id: \(lampId)")

        
//        if Core.sharedInstance.currentHome? != nil {
//            self.accessories.removeAll(keepCapacity: false)
//            if let accessories = Core.sharedInstance.currentHome!.accessories as? [HMAccessory] {
//                for accessory in accessories {
//                    if !contains(accessories, accessory) {
//                        self.accessories.insert(accessory, atIndex: 0)
//                        accessory.delegate = self
//                    }
//                }
//            }
//        }

        let accessory = Core.sharedInstance.currentHome!.accessories[lampId] as HMAccessory
        
//        services.removeAll(keepCapacity: true)
//        if let accessory = accessory {
//            for service in accessory.services as [HMService] {
//                if !contains(services, service) {
//                    services.append(service)
//                }
//            }
//        }
        
        service = accessory.services[1] as? HMService
        
//        characteristics.removeAll(keepCapacity: true)
//        
//        // Update the user interface for the detail item.
//        for characteristic in service!.characteristics as [HMCharacteristic] {
////            NSLog("CharDes: \(characteristic.characteristicTypeDescription())")
////            if colorButton?.enabled == true {
////                if characteristic.characteristicType == (HMCharacteristicTypeBrightness as String) {
////                    brightnessCharacteristic = characteristic
////                }
////                
////                if characteristic.characteristicType == (HMCharacteristicTypeHue as String) {
////                    hueCharacteristic = characteristic
////                }
////                
////                if characteristic.characteristicType == (HMCharacteristicTypeSaturation as String) {
////                    saturationCharacteristic = characteristic
////                }
////                
////                if characteristic.characteristicType == (HMCharacteristicTypePowerState as String) {
////                    onCharacteristic = characteristic
////                }
////            }
//            
//            if !contains(characteristics, characteristic) {
//                characteristics.append(characteristic)
//            }
//        }


        
        
        self.onCharacteristic(lampId, object: service!.characteristics[0] as HMCharacteristic, reply)
        
        // let object = characteristics[indexPath.row] as HMCharacteristic
        
    }
    
    func offLamp(lampId : Int) {
        println("OFF Lamp id: \(lampId)")
    }
    
    
    func onCharacteristic(lampId : Int, object : HMCharacteristic, reply: (([NSObject : AnyObject]!) -> Void)!) {
        
        var result = 0
        var replyInfo = NSMutableDictionary()

        
        var charDesc = object.characteristicType
        
        if let desc = HomeKitUUIDs[object.characteristicType] {
            charDesc = desc
        }
        
        switch (object.metadata.format as NSString) {
        case HMCharacteristicMetadataFormatBool:
            if (object.value != nil) {

                object.writeValue(!(object.value as Bool), completionHandler:
                    {
                        (error:NSError!) in
                        if (error != nil) {
                            NSLog("Change Char Error: \(error)")
                            replyInfo.setValue("Error", forKey: "error")
                            
                            reply(replyInfo)
                        } else {
                            result = object.value as Int
                            
                            replyInfo.setValue(lampId, forKey: "device_id")
                            replyInfo.setValue(result == 0 ? false : true, forKey: "device_state")
                            replyInfo.setValue("Hola mundo", forKey: "comments")
                            
                            reply(replyInfo)
                            
                        }
                    }
                )
            }
        default:
            NSLog("Unsupported")
        }
    }
    
    
    func accessory(accessory: HMAccessory!, service: HMService!, didUpdateValueForCharacteristic characteristic: HMCharacteristic!)
    {
        NSLog("HOME SERVICE didUpdateValueForCharacteristic:\(characteristic)")
//        NSNotificationCenter.defaultCenter().postNotificationName(characteristicUpdateNotification, object: nil, userInfo: ["accessory":accessory,"service":service,"characteristic":characteristic])
    }

    
}


