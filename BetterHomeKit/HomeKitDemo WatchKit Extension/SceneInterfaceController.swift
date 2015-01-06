//
//  SceneInterfaceController.swift
//  BetterHomeKit
//
//  Created by Andre Gatti on 1/6/15.
//  Copyright (c) 2015 Nlr. All rights reserved.
//

import WatchKit
import Foundation


class SceneInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func deepSeaButtonTapped() {
        self.setDeepSeaScene()
    }
    
    func setDeepSeaScene() {
        var userInfo = NSMutableDictionary()
        userInfo.setValue("scene", forKey: "operation")
        userInfo.setValue("deep-sea", forKey: "value")
        
        if (WKInterfaceController.openParentApplication(userInfo,
            reply: {(replyInfo, error) -> () in
                if ((error) != nil) {
                    println("Error trying to communicate with parent app - 1002")
                    println(error)
                    
                } else {
                    if (replyInfo != nil) {
                        var reply = replyInfo as NSDictionary
                        var result = reply.valueForKey("result") as Int
                        println("Device value: \(result)")
                    }
                }
        })) {
            println("Successful communication with parent app - 1000")
        } else {
            println("Error trying to communicate with parent app - 1001")
        }
    }
}
