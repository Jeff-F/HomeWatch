//
//  InterfaceController.swift
//  HomeWatch WatchKit Extension
//
//  Created by Ecil Teodoro on 12/29/14.
//  Copyright (c) 2014 ArcTouch. All rights reserved.
//

import WatchKit
import Foundation
import LampController

class InterfaceController: WKInterfaceController {

	@IBOutlet weak var lamp1Button: WKInterfaceButton!
	@IBOutlet weak var lamp2Button: WKInterfaceButton!
	@IBOutlet weak var lamp3Button: WKInterfaceButton!
	
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

	@IBAction func lamp1ButtonTapped() {
	}
	
	@IBAction func lamp2ButtonTapped() {
	}
	
	@IBAction func lamp3ButtonTapped() {
	}
	
	private 
	
}
