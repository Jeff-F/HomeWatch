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
    
    
    
    
    func onLamp(lampId : Int) {
        var characteristics = [HMCharacteristic]()

        
        println("ON Lamp id: \(lampId)")
        
        if Core.sharedInstance.currentHome? != nil {
            self.accessories.removeAll(keepCapacity: false)
            if let accessories = Core.sharedInstance.currentHome!.accessories as? [HMAccessory] {
                for accessory in accessories {
                    if !contains(accessories, accessory) {
                        self.accessories.insert(accessory, atIndex: 0)
                        accessory.delegate = self
                    }
                }
            }
        }

        accessory = accessories[lampId]
        
        services.removeAll(keepCapacity: true)
        if let accessory = accessory {
            for service in accessory.services as [HMService] {
                if !contains(services, service) {
                    services.append(service)
                }
            }
        }
        
        service = services[1]
        
        characteristics.removeAll(keepCapacity: true)
        
        // Update the user interface for the detail item.
        for characteristic in service!.characteristics as [HMCharacteristic] {
//            NSLog("CharDes: \(characteristic.characteristicTypeDescription())")
//            if colorButton?.enabled == true {
//                if characteristic.characteristicType == (HMCharacteristicTypeBrightness as String) {
//                    brightnessCharacteristic = characteristic
//                }
//                
//                if characteristic.characteristicType == (HMCharacteristicTypeHue as String) {
//                    hueCharacteristic = characteristic
//                }
//                
//                if characteristic.characteristicType == (HMCharacteristicTypeSaturation as String) {
//                    saturationCharacteristic = characteristic
//                }
//                
//                if characteristic.characteristicType == (HMCharacteristicTypePowerState as String) {
//                    onCharacteristic = characteristic
//                }
//            }
            
            if !contains(characteristics, characteristic) {
                characteristics.append(characteristic)
            }
        }

        self.onCharacteristic(characteristics[0])
        
        // let object = characteristics[indexPath.row] as HMCharacteristic
        
    }
    
    func offLamp(lampId : Int) {
        println("OFF Lamp id: \(lampId)")
    }
    
    
    func onCharacteristic(object : HMCharacteristic) -> Int {
        
        var result = 0
        
//        if !contains(object.properties as [String], HMCharacteristicPropertyWritable as String) {
//            return
//        }
        
        
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
                        } else {
                            result = object.value as Int
//                            dispatch_async(dispatch_get_main_queue(),
//                                {
////                                    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
////                                        cell.textLabel?.text = "\(object.value)"
////                                    }
//                                }
//                            )
                        }
                    }
                )
            }
        default:
            NSLog("Unsupported")
        }
        
        return result
    }
    
    
    
    func accessory(accessory: HMAccessory!, service: HMService!, didUpdateValueForCharacteristic characteristic: HMCharacteristic!)
    {
        NSLog("HOME SERVICE didUpdateValueForCharacteristic:\(characteristic)")
//        NSNotificationCenter.defaultCenter().postNotificationName(characteristicUpdateNotification, object: nil, userInfo: ["accessory":accessory,"service":service,"characteristic":characteristic])
    }

    
}


