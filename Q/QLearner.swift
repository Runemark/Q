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
    var learningRate:Float
    
    init(environment:Environment)
    {
        self.env = environment
        self.q = Array2D<Float>(rows:environment.states, cols:environment.actionCount, filler:Float(0.0))
        self.currentState = 0
        self.discountFactor = Float(0.5)
        self.learningRate = Float(1.0)
    }
    
//    func startNewIteration()
//    {
//        currentState = env.randomState()
//        
//        var goalStateReached = false
//        while(!goalStateReached)
//        {
//            goalStateReached = proceed()
//        }
//    }
    
    // Returns true if goal state was found, false otherwise
//    func proceed() -> Bool
//    {
////        let currentAction = env.randomAction(currentState)
//        
//        // Select action and observe reward, state
////        let reward = env.reward(currentState, action:currentAction)
////        let nextState = env.transition(currentState, action:currentAction)
//        
//        // Update our q function
//        
//        // With learning rate
////        q[currentState,currentAction] = q[currentState,currentAction] +  learningRate*(Float(reward) + discountFactor*maximalValueForActionsOfState(env.allActions(nextState), state:nextState))
//        
//        // Without learning rate
////        q[currentState,currentAction] = Float(reward) + discountFactor*maximalValueForActionsOfState(env.allActions(nextState), state:nextState)
//        
////        currentState = nextState
//        
//        return (nextState == env.goalState) ? true : false
//    }
    
//    func qVal(state:Int, action:Int) -> Float
//    {
//        return q[state,action]
//    }
    
//    func maximalValueForActionsOfState(actions:[Int], state:Int) -> Float
//    {
//        var bestValue = Float(-100000)
//        
//        for action in actions
//        {
//            let value = q[state, action]
//            if (value > bestValue)
//            {
//                bestValue = value
//            }
//        }
//        
//        return bestValue
//    }
}