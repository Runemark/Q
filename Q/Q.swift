//
//  Q.swift
//  Q
//
//  Created by Martin Mumford on 3/28/15.
//  Copyright (c) 2015 Runemark. All rights reserved.
//

import Foundation

class Q
{
    var states:Int
    var actions:Int
    
    var q:Array2D<Float>
    
    init(states:Int, actions:Int)
    {
        self.states = states
        self.actions = actions
        
        q = Array2D<Float>(rows:states, cols:actions, filler:Float(0.0))
    }
}