//
//  Q.swift
//  Q
//
//  Created by Martin Mumford on 3/28/15.
//  Copyright (c) 2015 Runemark. All rights reserved.
//

import Foundation

class QLearner
{
    var q:Array2D<Float>
    var currentState:Int
    var env:Environment
    
    init(environment:Environment)
    {
        self.env = environment
        self.q = Array2D<Float>(rows:environment.states, cols:environment.actions, filler:Float(0.0))
        self.currentState = 0
    }
    
    func newIteration()
    {
        currentState = randIntBetween(0, env.states-1)
        
    }
}