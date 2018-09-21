/*
CircularList.swift
Created by Landon Marchant on 7/10/17.
CircularList.swift contains a Node class and a CircularList class.
 All types start with Capital letters, like Int, T, String
 */
/**
 Node class takes any type. Contains:
    initializer: initializes the Node
 
 CircularListIterator initializes the CircularList

 CircularList class contains:
    initializer: initializes the CircularList using CircularListIterator
    first: identify the first value of the CircularList
    last: identify the last value of the CircularList
    add: adds value to the beginning of the CircularList
    append: adds value to the end of the CircularList
    popFirst: removes the first value of the CircularList
    popLast: removes the last value of the CircularList
    
*/

import Foundation

/// class Node takes any type, and builds a singular linked list.

class Node<T> {
    /// fileprivate means
    /// - Parameters:
    ///   - next: the node being built
    ///   - data: what node contains. Takes any type.
    
    fileprivate var next: Node<T>?
    fileprivate var data: T
    
    
    /// Initializes the node
    ///
    /// - Parameters:
        init(_ value: T, with tail: Node<T>? = nil) {
        data = value
        next = tail
    }
}

/// Iterates over the CircularList, one Node at a time.
class CircularListIterator<T>: IteratorProtocol {
    // let target and var index represent the state of the iterator. 
    // Every iterator has its own state.
    
    let target: CircularList<T>
    var finger : Node<T>?
    
    init(_ target: CircularList<T>) {
        // target is name of a parameter, so the one on the right refers to
        // parameter. left side refers to the constant within the class.
        self.target = target
        finger = target.tail?.next
    }
    
    /// Next iterates over the CircularList.
    ///
    /// - Returns: the next value in the list, will eventually return nil.
    func next() -> T? {
        if finger === nil {
            return nil
        }
        else {
            let result = finger!.data
            if target.tail === finger {
                finger = nil
                
            } else {
                finger = finger!.next
            }
            return result
        }
    }
}
    /// Class CircularList takes any type of data and creates a
    // linked list made of nodes.
    /// The list begins at the tail.
    /// Nodes are created in class Node<T>

class CircularList<T> : Sequence {
    
    /// Counts the number of Nodes in the CircularList
    fileprivate var tail: Node<T>?
    var count: Int {
        if tail == nil {
            return 0
        }
        else {
            var result = 1
            // Tail is the 'start' of the list
            var finger = tail!.next
            while !(finger! === tail!) {
                finger = finger!.next
                result += 1
            }
            return result
        }
    }
    
    /// Makes the CircularList iterator
    ///
    /// - Returns: itself, the CircularListIterator
    
    func makeIterator() -> CircularListIterator<T> {
        return CircularListIterator<T>(self)
    }
    
    /// Initializes the new CircularList. 
    /// Tail is initialized as nil.
    init() {
        tail = nil
    }
    
    /// Boolean value, return True if tail is nil.
    var isEmpty: Bool {
        return tail === nil
    }
    
    /// Determines which Node is first in the CircularList
    var first: T? {
        if isEmpty{
            return nil
        }
        else {
            return tail!.next!.data
        }
    }
    
    /// Determines which Node is last in the CircularList
    var last: T? {
        if isEmpty {
            return nil
        }
        else {
            return tail!.data
        }
    }
    
    /// Adds a value to the beginning of the list.
    ///
    /// - Parameter value: newHead is the added value.
    func add(_ value: T) {
        if isEmpty {
            tail = Node<T>(value)
            tail!.next = tail
        }
        else {
            let newHead = Node<T>(value)
            newHead.next = tail!.next
            tail!.next = newHead
        }
    }
    
    /// Appends a value to the end of the list.
    ///
    /// - Parameter value: Tail is reassigned to reference the following Node.
    func append(_ value: T) {
        add(value)
        tail = tail!.next
    }
    
    /// Removes the first value from CircularList
    ///
    /// - Returns: Returns and removes first value from CircularList. 
    ///            If nil, return nil
    
    func popFirst() -> T? {
        if isEmpty {
            return nil
        }
        else {
            let result = tail!.next!.data
            if tail === tail!.next {
                tail = nil
            }
            else {
            tail!.next = tail!.next!.next
            }
            return result
        }
    }
    
    /// removes the last value from CircularList
    ///
    /// - Returns: Returns and removes the last value from CircularList. 
    ///            Reassigns the last value in order to return popFirst
    func popLast() -> T? {
        if isEmpty {
            return nil
        }
        else {
            var almostLast = tail!
            while !(almostLast.next === tail) {
                almostLast = almostLast.next!
            }
            tail = almostLast
            return popFirst()
        }
    }
}
var l : CircularList<Int> = CircularList<Int>()
l.add(3)
l.add(42)
l.add(4)
//print(l.count)
//print(l.popFirst()!)
//print(l.popLast()!)

for v in l {
print(v)
}
