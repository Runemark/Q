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
    
    // Actions available (in general)
    var actionCount:Int
    // The actions available from each state
    // We can't actually use an array2D here, because the matrix doesn't have to be complete (not all states have all actions, some states may have no actions)
    var actions:[[Int]]
    
    var goalState:Int
    
    // state transition function
    var delta:Array2D<[Int]>
    // reward function
    var r:Array2D<[Float]>
    
    convenience init()
    {
        let randWidth = randIntBetween(2, 10)
        let randHeight = randIntBetween(2, 10)
        let stateCount = randWidth*randHeight
        let randomGoalState = randIntBetween(0, stateCount-1)
        
        self.init(width:randWidth, height:randHeight, actions:4, goalState:randomGoalState)
    }
    
    init(width:Int, height:Int, actions:Int, goalState:Int)
    {
        self.states = width*height
        self.actions = [[Int]]()
        self.actionCount = actions
        
        self.goalState = goalState
        
        self.delta = Array2D<[Int]>(rows:width, cols:height, filler:[-1])
        self.r = Array2D<[Float]>(rows:width, cols:height, filler:[Float(-1.0)])
        
        for _ in 0..<states
        {
            self.actions.append([Int]())
        }
        
        // populate transition function
        for x in 0..<width
        {
            for y in 0..<height
            {
                let tileIndex = x*(height-1) + y
                // up (action 0)
                if (y > 0)
                {
                    self.actions[tileIndex].append(0)
                    
                    let upTransitionTileIndex = x*(height-1) + (y+1)
                    delta[x,y].append(upTransitionTileIndex)
                }
                // right (action 1)
                if (x < width-1)
                {
                    self.actions[tileIndex].append(1)
                    
                    let rightTransitionTileIndex = (x+1)*(height-1) + y
                    delta[x,y].append(rightTransitionTileIndex)
                }
                // down (action 2)
                if (y < height-1)
                {
                    self.actions[tileIndex].append(2)
                    
                    let downTransitionTileIndex = x*(height-1) + (y-1)
                    delta[x,y].append(downTransitionTileIndex)
                }
                // left (action 4)
                if (x > 0)
                {
                    self.actions[tileIndex].append(3)
                    
                    let leftTransitionTileIndex = (x-1)*(height-1) + y
                    delta[x,y].append(leftTransitionTileIndex)
                }
            }
        }
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
    
    func allActions(state:Int) -> [Int]
    {
        var allActions = [Int]()
        for action in actions[state]
        {
            allActions.append(action)
        }
        return allActions
    }
    
    func randomState() -> Int
    {
        return randIntBetween(0, states-1)
    }
    
    func randomAction(state:Int) -> Int
    {
        let actionsForState = actions[state]
        
        return randIntBetween(0, actionsForState[actionsForState.count-1])
    }
    
//    func transition(stateX:Int, stateY:Int, action:Int) -> Int
//    {
//        return delta[stateX,stateY]
//    }
//    
//    func reward(state:Int, action:Int) -> Float
//    {
//        return r[state,action]
//    }
}