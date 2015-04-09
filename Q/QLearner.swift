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
    var discountFactor:Float
    
    init(environment:Environment)
    {
        self.env = environment
        self.q = Array2D<Float>(rows:environment.states, cols:environment.actions, filler:Float(0.0))
        self.currentState = 0
        self.discountFactor = Float(0.0)
    }
    
    func newIteration()
    {
        currentState = env.randomState()
        let currentAction = env.randomAction()
        
        // Select action and observe reward, state
        let reward = env.reward(currentState, action:currentAction)
        let nextState = env.transition(currentState, action:currentAction)
        
        // Update our q function
        q[currentState,currentAction] = Float(reward) + discountFactor*maximalValueForActionsOfState(env.allActions(), state:nextState)
    }
    
    func qVal(state:Int, action:Int) -> Float
    {
        return q[state,action]
    }
    
    func maximalValueForActionsOfState(actions:[Int], state:Int) -> Float
    {
        var bestValue = Float(-100000)
        
        for action in actions
        {
            let value = q[state, action]
            if (value > bestValue)
            {
                bestValue = value
            }
        }
        
        return bestValue
    }
}