/**
 vectorTools.swift
 Created by Landon Marchant on 6/22/17.
 All types start with Capital letters, like Int, T, String
 */


import Foundation
/**
 Vector Iterator, takes any type. Performs iterator protocol.
 This will iterate over the vector index one item at a time.
 
 - returns:
    - nil when index is not less than target Vector's count.
    - result. Index item from target Vector.
 */
class VectorIterator<T>: IteratorProtocol {
    let target: Vector<T>
    var index: Int
    init(target: Vector<T>) {
        self.target = target
        self.index = 0
    }
    /**
     Moves iterator through the target Vector.
     */
    func next() -> T? {
        guard index < target.count
            else {
                return nil
        }
        /**
         Decrements index
         */
        let result = target[index]
        index = index + 1
        return result
    }
}
/**
 Vector is a generic container for elements of type T, constraint Sequence.
 - returns:
 
 - parameters:
 - private var data: array containing optional elements of type T.
 - private var size: an integer value counting the items in array.
 - private var alloc: allocation. an integer value indicating how many slots the array contains.
 
 - includes:
 - allocation initializer: initializes the array, default allocation 10.
 - Vector iterator: creates an iterator
 - append function: appends values to the array
 - private function, ensure capacity: ensures array has enough space for the index.
 - subscript: rewrites data to include new values
 - getLast: returns last element in the data array
 - popLast: returns and removes the last element in data array
 - insert: inserts a value at a specific, indicated, location.
 - remove: removes a value at a specific, indicated, location.
 */

class Vector<T>: Sequence {
    private var data: [T?]
    private var size: Int
    private var alloc: Int
    
    /**
     Initializes the array
     
     - parameters:
     - private var alloc: allocates a default of ten slots.
     - private var size: default 0.
     - private var data: array of type <T?>. Default value nil, count: alloc.
     - var count: integer value. returns size.
     - var capacity: integer value. returns allocation.
     
     - returns:
     - alloc: how many slots are in the array
     - size: count of values in the array, default 0
     */
    
    init(withAllocation allocation: Int = 10) {
        alloc = allocation
        size = 0
        data = Array<T?>(repeating: nil, count: alloc)
    }
    var count: Int {
        return size
    }
    var capacity: Int {
        return alloc
    }
    /**
     Creates Vector iterator. This iterator travels over, and returns Vector. The target Vector for this Vector iterator is itself.
     */
    
    func makeIterator() -> VectorIterator<T> {
        return VectorIterator<T>(target: self)
    }
    /**
     Function ensures that the array has enough capacity to append a value <T>, increments size by one.
     */
    func append(_ value: T) {
        ensure(hasCapacity: size+1)
        data[size] = value
        size += 1
    }
    /**
     private func ensure will increase allocation by doubling capacity.
     
     - parameters:
     - var temp: data array of optional T type, default repeating nil. default count is alloc.
     */
    private func ensure(hasCapacity c: Int) {
        if c <= capacity {
            return
        }
        alloc = c*2
        var temp = [T?](repeating: nil, count: alloc)
        for index in 0..<size {
            temp[index] = data[index]
        }
        data = temp
    }
    /**
     func subscript retrieves i as integer value, returns <T>. Includes appended value in data array.
     */
    subscript(i: Int) -> T {
        get {
            return data[i]! as T
        }
        set(newValue) {
            data[i] = newValue
        }
    }
    /**
     func getLast returns the last element in the data array.
     */
    func getLast() -> T {
        return data[size-1]! as T
    }
    /**
     func popLast removes and returns the last element in the data array.
     
     - parameters:
     - let lastElement: last element in the data array.
     
     - returns:
     - unpacks optional last element in the data array as type <T>.
     */
    func popLast() -> T {
        let lastElement = data[size - 1]
        size = size - 1
        data[size] = nil
        return lastElement! as T
        
    }
    /**
     func insert will add a new value to the array, at a specified location.
     It finds a location to insert a value then moves the array values so the new value fits.
     
     - parameters:
     - var finger: defaults to last item in the array. Identifies and tracks the insert location.
     */
    func insert(_ newElement: T, at i: Int) {
        ensure(hasCapacity: size + 1)
        var finger: Int = size - 1
        while i <= finger {
            data[finger + 1] = data[finger]
            finger = finger - 1
            
        }
        size = size + 1
        data[i] = newElement
    }
    
    /**
     func remove selects value at indicated index, ensures the index is not out of array range, and removes it.
     
     - parameters:
     - var eraser: default equal to indicated index value.
     - let result: is data index, unwrapped.
     
     - returns:
     - result: result, after indicated value is removed and values are moved to fill the empty space.
     
     */
    func remove(at index: Int) -> T {
        assert(index < size && index >= 0,"Index out of range.")
        var eraser = index
        let result = data[index]!
        while (eraser < size - 1) {
            data[eraser] = data[eraser + 1]
            eraser = eraser + 1
        }
        data[size - 1] = nil
        size = size - 1
        return result
    }
    
}
let v = Vector<Int>(withAllocation: 3)

v.append(1)
v.append(2)
v.append(3)
v.append(-2)
//print(v.popLast())
//print(v.popLast())

v.insert(6, at: 0)
var a = v.sorted()
a.remove(at:0)
for i in a {
    print("item = \(i)")
}

let removed = v.remove(at: 0)
print(removed)
for i in 0..<v.count {
    print("item \(i) in v = \(v[i])")
}



