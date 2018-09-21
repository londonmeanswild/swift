//
//  Vector attempt.swift
//  
//
//  Created by Landon Marchant on 6/20/17.
//Creating a structure that contains objects all of the same type. Will enable adding features that lists don't have. Good enough for
// now

import Foundation

class Vector{
    private var data: [Any?] // anything can be assigned to this list. when items are returned they're not optional.
    private var size: Int // will always be an integer, 0 to infinity. not optional
    private var alloc: Int // see above
    
    init(withAllocation allocation: Int = 10) { //by default, init gives 10 cells.
        alloc = allocation
        size = 0
        data = Array<Any?>(repeating: nil, count: allocation) // nil in each of 10 slots
    }
    var count: Int {
        return size
    }
    var capacity: Int {
        return alloc
    }
    func append(_ value: Any) { //accepts any type but NOT nil
        ensure(hasCapacity: size+1)
        data[size] = value
        size += 1
    }
    private func ensure(hasCapacity c: Int){
        if c <= capacity {
            return
        }
        alloc = c*2
        var temp = [Any?](repeating: nil, count: alloc)
        for index in 0..<size {
            temp[index] = data[index] //for all values 0 to size but not including, move from data to temp
        }
        data = temp //data points to new array which has copy of old array in it
    }
    subscript(i: Int) -> Any {
        get {
            return data[i]! as Any //! = really know there is an i value here. 'as Any' changes type to Any from Any?
        }
        set(newValue) {
            data[i] = newValue //newValue is default
        }
    }
}

var v = Vector(withAllocation: 2)


v.append(3)
v.append(3)
v.append(3)
v.append(3)

v[1] = "hello world"
print(v.count)
print(v.capacity)
for i in 0..<v.count {
    print(v[i])
}
