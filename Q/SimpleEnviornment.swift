//
//  SimpleEnviornment.swift
//  Q
//
//  Created by Alicia Cicon on 4/10/15.
//  Copyright (c) 2015 Runemark. All rights reserved.
//

import Foundation

class SimpleEnvironment
{
    var tileMap:TileMap
    var goalState:Coord
    
    // Creates a random environment
    init(width:Int, height:Int, goalX:Int, goalY:Int)
    {
        self.tileMap = TileMap(width:width, height:height)
        self.goalState = Coord(x:goalX, y:goalY)
    }
}
