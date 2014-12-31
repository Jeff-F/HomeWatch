//
//  Lamp.swift
//  HomeWatch
//
//  Created by Ecil Teodoro on 12/29/14.
//  Copyright (c) 2014 ArcTouch. All rights reserved.
//

import Foundation

class Lamp {
	
	private var id : Int
	private var state : Bool
	
	init(id: Int, state : Bool) {
		self.id = id
		self.state = state
	}
	
	func switchState() -> Bool {
		self.state = !self.state
		return self.state
	}
	
	func getState() -> Bool {
		return self.state
	}
	
	func getId() -> Int {
		return self.id
	}
	
}