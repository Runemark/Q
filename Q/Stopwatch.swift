//
//  Stopwatch.swift
//  Q
//
//  Created by Martin Mumford on 3/28/15.
//  Copyright (c) 2015 Runemark. All rights reserved.
//

import Foundation

class Stopwatch
{
    var startTime:CFAbsoluteTime
    
    init()
    {
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    func start()
    {
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    func mark() -> CFAbsoluteTime
    {
        return CFAbsoluteTimeGetCurrent() - startTime
    }
}