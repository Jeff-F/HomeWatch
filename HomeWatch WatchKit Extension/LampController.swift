//
//  LampController.swift
//  HomeWatch
//
//  Created by Ecil Teodoro on 12/29/14.
//  Copyright (c) 2014 ArcTouch. All rights reserved.
//

import Foundation

class LampController {
	
	func switchLampState(lamp : Lamp) -> Bool {
		return lamp.switchState();
	}
	
	func getLampState(lamp : Lamp) -> Bool {
		return lamp.getState()
	}
		
}