//
//  TileMap.swift
//  Q
//
//  Created by Alicia Cicon on 4/10/15.
//  Copyright (c) 2015 Runemark. All rights reserved.
//

import Foundation

func ==(lhs:Coord, rhs:Coord) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

class Coord:Hashable
{
    var x:Int
    var y:Int
    
    init(x:Int, y:Int)
    {
        self.x = x
        self.y = y
    }
    
    var hashValue : Int {
        get {
            return "\(self.x),\(self.y)".hashValue
        }
    }
}

struct Tile
{
    var blocking:Bool
}

class TileMap
{
    var tiles:Array2D<Tile>
    var width:Int
    var height:Int
    
    // Creates a random environment
    init(width:Int, height:Int)
    {
        self.width = width
        self.height = height
        self.tiles = Array2D<Tile>(rows:width, cols:height, filler:Tile(blocking:false))
    }
    
    func tileInMapBounds(x:Int, y:Int) -> Bool
    {
        return (x >= 0 && y >= 0 && x < width && y < height) ? true : false
    }
    
    func tileAt(x:Int, y:Int) -> Tile
    {
        return tiles[x,y]
    }
    
    func neighboringCoordsForTileAt(pos:Coord) -> [Coord]
    {
        var neighbors = [Coord]()
        
        let position_N = Coord(x:pos.x, y:pos.y+1)
        let position_E = Coord(x:pos.x+1, y:pos.y)
        let position_S = Coord(x:pos.x, y:pos.y-1)
        let position_W = Coord(x:pos.x-1, y:pos.y)
        
        if (tileInMapBounds(position_N.x, y:position_N.y))
        {
            neighbors.append(position_N)
        }
        
        if (tileInMapBounds(position_E.x, y:position_E.y))
        {
            neighbors.append(position_E)
        }
        
        if (tileInMapBounds(position_S.x, y:position_S.y))
        {
            neighbors.append(position_S)
        }
        
        if (tileInMapBounds(position_W.x, y:position_W.y))
        {
            neighbors.append(position_W)
        }
        
        return neighbors
    }
    
    func neighboringTilesForTileAt(pos:Coord) -> [Tile]
    {
        var neighbors = [Tile]()
        
        for neighboringCoord in neighboringCoordsForTileAt(pos)
        {
            neighbors.append(tileAt(neighboringCoord.x, y:neighboringCoord.y))
        }
        
        return neighbors
    }
    
    func pathBetweenTiles(a:Coord, b:Coord) -> [Coord]
    {
        // Perform the A* search algorithm (heuristic is distance between two points)
        var closedSet = Set<Coord>()
        var openSet = Set<Coord>()
        
        openSet.insert(a)
        
        var cameFrom = Array2D<Coord>(rows:width, cols:height, filler:Coord(x:0, y:0))
        
        var gScore = Array2D<Float>(rows:width, cols:height, filler:Float(0.0)) // The cost from a to every other node
        var fScore = Array2D<Float>(rows:width, cols:height, filler:Float(1000)) // The estimated total cost from a to the goal through every other node
        
        gScore[a.x, a.y] = Float(0.0)
        fScore[a.x, a.y] = Float(gScore[a.x, a.y]) + heuristicEstimate(a, b:b)
        fScore[b.x, b.y] = Float(0.0)
        
        while (!openSet.isEmpty)
        {
            println("doot")
            // Set current to the node in the openSet having the lowest fScore
            var currentNode = coordWithMinimumHeuristic(openSet, fScore:fScore)
            
            if (currentNode.x == b.x && currentNode.y == b.y)
            {
                return reconstructPath(cameFrom, origin:a, goal:b)
            }
            else
            {
                // Remove current from open set
                openSet.remove(currentNode)
                // Add current to closed set
                closedSet.insert(currentNode)
                
                for neighbor in neighboringCoordsForTileAt(currentNode)
                {
                    if (closedSet.contains(neighbor))
                    {
                        // (skip this neighbor, it's already been checked)
                    }
                    else
                    {
                        let tentativeGScore = Float(gScore[currentNode.x, currentNode.y]) + Float(1.0)
                        
                        if (!openSet.contains(neighbor) || tentativeGScore < gScore[neighbor.x, neighbor.y])
                        {
                            cameFrom[neighbor.x, neighbor.y] = currentNode
                            gScore[neighbor.x, neighbor.y] = tentativeGScore
                            fScore[neighbor.x, neighbor.y] = Float(gScore[neighbor.x, neighbor.y]) + heuristicEstimate(neighbor, b:b)
                            
                            if (!openSet.contains(neighbor))
                            {
                                openSet.insert(neighbor)
                            }
                        }
                    }
                }
            }
        }
        
        return [Coord]()
    }
    
    func reconstructPath(cameFrom:Array2D<Coord>, origin:Coord, goal:Coord) -> [Coord]
    {
        var totalPath = [Coord]()
        var current = goal
        totalPath.append(current)
        
        while (current.x != origin.x || current.y != origin.y)
        {
            current = cameFrom[current.x, current.y]
            totalPath.append(current)
        }
        
        return totalPath
    }
    
    func coordWithMinimumHeuristic(openSet:Set<Coord>, fScore:Array2D<Float>) -> Coord
    {
        var minimumValueSoFar:Float = 100000
        var minimumCoordSoFar = Coord(x:-1, y:-1)
        
        for coord in openSet
        {
            let coordHeuristic = fScore[coord.x, coord.y]
            if (coordHeuristic < minimumValueSoFar)
            {
                minimumValueSoFar = coordHeuristic
                minimumCoordSoFar = coord
            }
        }
        
        return minimumCoordSoFar
    }
    
    func heuristicEstimate(a:Coord, b:Coord) -> Float
    {
        return distanceBetweenPoints(a, b:b)
    }
    
    func distanceBetweenPoints(a:Coord, b:Coord) -> Float
    {
        return sqrtf(Float(pow(Double(a.x-b.x), 2.0)) + Float(pow(Double(a.y-b.y), 2.0)))
    }
    
    func tilesNotMemberOfTileset(tiles:[Coord], tileset:[Coord]) -> [Coord]
    {
        var tilesNotInTileset = [Coord]()
        
        for coord in tiles
        {
            if (!tileIsMemberOfTileset(coord, tileset:tileset))
            {
                tilesNotInTileset.append(coord)
            }
        }
        
        return tilesNotInTileset
    }
    
    func tileIsMemberOfTileset(t:Coord, tileset:[Coord]) -> Bool
    {
        for coord in tileset
        {
            if (t.x == coord.x && t.y == coord.y)
            {
                return true
            }
        }
        
        return false
    }
}