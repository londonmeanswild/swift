//
//  Vector attempt.swift
//  
//
//  Created by Landon Marchant on 6/20/17.
//Creating a structure that contains objects all of the same type. Will enable adding features that lists don't have. Good enough for
// now

import Foundation

class Vector{
    var data: [Any?] // anything can be assigned to this list. when items are returned they're not optional.
    var size: Int // will always be an integer, 0 to infinity. not optional
    var alloc: Int // see above
    
    init(withAllocation allocation: Int = 10) { //by default, init gives 10 cells.
        alloc = allocation
        size = 0
        data = [Any?](10)
    }
}

var v = Vector()
