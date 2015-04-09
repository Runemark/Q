//
//  Environment.swift
//  Q
//
//  Created by Alicia Cicon on 4/9/15.
//  Copyright (c) 2015 Runemark. All rights reserved.
//

import Foundation

class Environment
{
    var states:Int
    var actions:Int
    
    // state transition function
    var delta:Array2D<Int>
    // reward function
    var r:Array2D<Float>
    
    init(states:Int, actions:Int)
    {
        self.states = states
        self.actions = actions
        
        self.delta = Array2D<Int>(rows:states, cols:actions, filler:0)
        self.r = Array2D<Float>(rows:states, cols:actions, filler:0)
    }
    
    func allStates() -> [Int]
    {
        var allStates = [Int]()
        for index in 0..<states
        {
            allStates.append(index)
        }
        return allStates
    }
    
    func allActions() -> [Int]
    {
        var allActions = [Int]()
        for index in 0..<actions
        {
            allActions.append(index)
        }
        return allActions
    }
    
    func randomState() -> Int
    {
        return randIntBetween(0, states-1)
    }
    
    func randomAction() -> Int
    {
        return randIntBetween(0, actions-1)
    }
    
    func transition(state:Int, action:Int) -> Int
    {
        return delta[state,action]
    }
    
    func reward(state:Int, action:Int) -> Float
    {
        return r[state,action]
    }
}