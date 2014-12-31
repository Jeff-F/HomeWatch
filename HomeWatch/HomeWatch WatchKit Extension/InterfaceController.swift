//
//  InterfaceController.swift
//  HomeWatch WatchKit Extension
//
//  Created by Ecil Teodoro on 12/29/14.
//  Copyright (c) 2014 ArcTouch. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
	
	var lamp1 = Lamp(id: 1, state: false)
	var lamp2 = Lamp(id: 2, state: false)
    var lamp3 = Lamp(id: 3, state: false)
	
	let lampController = LampController()

	@IBOutlet weak var lamp1Button: WKInterfaceButton!
	@IBOutlet weak var lamp2Button: WKInterfaceButton!
	@IBOutlet weak var lamp3Button: WKInterfaceButton!
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
		self.updateLampStates();
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
		lampController.switchLampState(lamp1)
		updateLampStates()
	}
	
	@IBAction func lamp2ButtonTapped() {
		lampController.switchLampState(lamp2)
		updateLampStates()
	}
	
	@IBAction func lamp3ButtonTapped() {
		lampController.switchLampState(lamp3)
		updateLampStates()
	}
	
	private func updateLampStates() {
		lamp1Button.setBackgroundImageNamed(lamp1.getState() ? "light-bulb-on" : "light-bulb-off")
		lamp2Button.setBackgroundImageNamed(lamp2.getState() ? "light-bulb-on" : "light-bulb-off")
		lamp3Button.setBackgroundImageNamed(lamp3.getState() ? "light-bulb-on" : "light-bulb-off")
	}
}
