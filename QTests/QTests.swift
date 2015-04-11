//
//  QTests.swift
//  QTests
//
//  Created by Alicia Cicon on 4/10/15.
//  Copyright (c) 2015 Runemark. All rights reserved.
//

import Cocoa
import XCTest

import Q

class QTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMapInitialization() {
        var tileMap = TileMap(width:2, height:1)
        
        XCTAssert(tileMap.width == 2, "Pass")
        XCTAssert(tileMap.height == 1, "Pass")
    }
    
    func testDistanceBetweenPoints() {
        
        var tileMap = TileMap(width:1, height:1)

        // No distance (same coordinate)
        XCTAssert(tileMap.distanceBetweenPoints(Coord(x:0, y:0), b:Coord(x:0, y:0)) == 0, "Pass")
        XCTAssert(tileMap.distanceBetweenPoints(Coord(x:1, y:0), b:Coord(x:1, y:0)) == 0, "Pass")
        XCTAssert(tileMap.distanceBetweenPoints(Coord(x:0, y:1), b:Coord(x:0, y:1)) == 0, "Pass")
        XCTAssert(tileMap.distanceBetweenPoints(Coord(x:1, y:1), b:Coord(x:1, y:1)) == 0, "Pass")
        
        // Adjacent tiles (distance = 1)
        XCTAssert(tileMap.distanceBetweenPoints(Coord(x:0, y:0), b:Coord(x:1, y:0)) == 1, "Pass")
        XCTAssert(tileMap.distanceBetweenPoints(Coord(x:0, y:0), b:Coord(x:0, y:1)) == 1, "Pass")
        XCTAssert(tileMap.distanceBetweenPoints(Coord(x:1, y:0), b:Coord(x:0, y:0)) == 1, "Pass")
        XCTAssert(tileMap.distanceBetweenPoints(Coord(x:0, y:1), b:Coord(x:0, y:0)) == 1, "Pass")
        
        // Diagonal tiles (distance = sqrt(2))
        XCTAssert(tileMap.distanceBetweenPoints(Coord(x:0, y:0), b:Coord(x:1, y:1)) == sqrtf(Float(2.0)), "Pass")
        XCTAssert(tileMap.distanceBetweenPoints(Coord(x:1, y:1), b:Coord(x:0, y:0)) == sqrtf(Float(2.0)), "Pass")
    }
    
    func testNeighbors() {
        
        var tileMap = TileMap(width:5, height:5)
        
        let cornerNeighbors_SW = tileMap.neighboringCoordsForTileAt(Coord(x:0, y:0))
        let cornerNeighbors_NW = tileMap.neighboringCoordsForTileAt(Coord(x:0, y:4))
        let cornerNeighbors_NE = tileMap.neighboringCoordsForTileAt(Coord(x:4, y:4))
        let cornerNeighbors_SE = tileMap.neighboringCoordsForTileAt(Coord(x:4, y:0))
        
        XCTAssert(coordArrayCompare(cornerNeighbors_SW, b:[Coord(x:0, y:1), Coord(x:1, y:0)]), "Pass")
        XCTAssert(coordArrayCompare(cornerNeighbors_NW, b:[Coord(x:1, y:4), Coord(x:0, y:3)]), "Pass")
        XCTAssert(coordArrayCompare(cornerNeighbors_NE, b:[Coord(x:4, y:3), Coord(x:3, y:4)]), "Pass")
        XCTAssert(coordArrayCompare(cornerNeighbors_SE, b:[Coord(x:4, y:1), Coord(x:3, y:0)]), "Pass")
    }
    
    func coordArrayCompare(a:[Coord], b:[Coord]) -> Bool
    {
        if (a.count == b.count)
        {
            for index in 0..<a.count
            {
                let a_coord = a[index]
                let b_coord = b[index]
                
                if (a_coord.x != b_coord.x || a_coord.y != b_coord.y)
                {
                    return false
                }
            }
            
            return true
        }
        else
        {
            return false
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
