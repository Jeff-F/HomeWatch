//
//  LampController.swift
//  HomeWatch
//
//  Created by Ecil Teodoro on 12/29/14.
//  Copyright (c) 2014 ArcTouch. All rights reserved.
//

import Foundation

class LampController {
	
	static func isLampOn(lamp : Int) -> Bool {
		switch lamp {
		case 1 :
			return true
		case 2 :
			return false
		case 3 :
			return true
		}
	}
}