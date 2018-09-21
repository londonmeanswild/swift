/*
LinkedListClass.swift
Created by Landon Marchant on 7/5/17.
LinkedListClass contains a Node class and LinkedList class.
 All types start with Capital letters, like Int, T, String
 */
 
 /*
 Node class takes any type.
    initializer, initializes the node.
    length counter, returns the length of linked list.
    append function, adds a value to the end of the linked list. 
 LinkedList class contains:
    initializer, initializes the linked list. 
    add, adds a new value to the linked list by creating a new head,
    old head follows.
    append, adds a value to the end of the linked list.
 
 */

import Foundation

/// class Node takes any type, and builds a singular linked list.

class Node<T> {

    /// - Parameters:
    ///   - next: the node being built
    ///   - data: what node contains. Takes any type. 
    
    fileprivate var next: Node<T>?
    fileprivate var data: T

    
    /// Initializes the node
    ///
    /// - Parameters:
    ///   - value: any type, assigned to data.
    ///   - tail: what follows this initialized node, default nil.
    init(_ value: T, with tail: Node<T>? = nil) {
        data = value
        next = tail
    }
    
        /// Returns the length of the list
        var count: Int {
        var result = 1
            if next != nil {
            // we can do this because next != nil
            // considers all items that follow.
                result += next!.count
                }
            return result
            }
    
    /// Appends a value to the end of the list
    ///
    /// - Parameter value: if next node is nil, then create a new node.
    ///     Otherwise, append to tail.
    func append(_ value: T) {
        if next == nil {
            // no tail, tail defaults to nil.
            next = Node<T>(value)
        }
        else {
            next!.append(value)
        }
    }
}

/// class LinkedList takes any type of data and creates a linked list made of
/// nodes.
/// Nodes are created in the previous class Node<T>

class LinkedList<T> : Sequence {

    
    /// Assigns head node. Counts the number of nodes in the list.
    /// Returns count if head is not nil, or zero if head is nil.
    fileprivate var head: Node<T>?
    var count: Int {
        if head == nil {
            return 0
        }
        else {
            // force unwraps head because we know it won't be nil
            return head!.count
                
            }
    }
    
    /// Initializes a new LinkedList with a nil head.
    init() {
        head = nil
    }
    
    /// Adds value to the beginning of the LinkedList. Constructs the new node,
    /// and inserts before the previously existing values.
    /// - Parameter value: assign head to be new node.
    func add(_ value: T) {
        head = Node<T>(value, with: head)
    }
    
    /// First determines if the first node is nil or not. Returns nil or value.
    var first: T? {
        if head == nil {
            return nil
        }
        else {
            return head!.data
        }
    }
    // we know func append is a fucntion because it requires data
    /// Appends a value of any type at the end of LinkedList
    ///
    /// - Parameter value: if the first node is nil, add value. Otherwise,
    ///     append the value to the end of the list.
    ///     It is force unwrapped because it cannot be nil.
    func append(_ value: T) {
        if head == nil {
            add(value)
        }
        else {
            head!.append(value)
        }
    }
    
    /// Boolean. Returns if LinkedList is empty, or count.
    var isEmpty: Bool {
        return count == 0
    }
    
    /// inserts a value of any type at a location.
    ///
    /// - Parameters:
    ///   - value: value for any type of value to be inserted
    ///   - index: location, integer type
    func insert(_ value: T, at index: Int) {
        guard 0 <= index && index <= count else { return }
        var i = index
        if (i == 0) {
           add(value)
        }
        else {
            var prev : Node<T> = head!

           while(i > 1) {
              prev = prev.next!
              i = i - 1
           }
            let new: Node<T> = Node<T>(value, with: prev.next)
            prev.next = new
       
        }
    }

    /// subscript finds an item in the list
    ///
    /// - Parameter i: location, specified by an integer
    subscript(_ i: Int) -> T? {
        // nil is reserved to mean item not found in list, and list != empty
        guard 0 <= i && i < count else { return nil }
        // i is a valid index, list != empty
        // current is a pointer to a node, currentIndex is Int
        var currentIndex = 0
        // we know Node is valid because of guard, have to tell code with !
        var current: Node<T> = head!
        while currentIndex  < i {
            currentIndex += 1
            // know next will not be nil because of guard
            current = current.next!
        }
        return current.data
    }
    func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator<T>(self)
    }
    class LinkedListIterator<T>: IteratorProtocol {
        // let target and var index represent the state of the iterator.
        // Every iterator has its own state.
        let target: LinkedList<T>
        var index : Int
        
        init(_ target: LinkedList<T>) {
            // target is name of a parameter, so the one on the right refers
            // to parameter. left side refers to the constant within the class.
            self.target = target
            index = 0
        }
        // we want to be able to return nil, so no guard statement.
        // need to return nil to signal to future "for" loops
        // that we have run out of values
        func next() -> T? {
            guard 0 <= index && index < target.count else { return nil}
            let result = target[index]!
            // now type is T not T?
            index += 1
            return result
        }
    }
}


var l: LinkedList<Int> = LinkedList<Int>()
l.add(3)
l.append(4)
l.insert(5, at: 1)


print(l.first!)
print(l.count)
for i in 0..<l.count {
    print(l[i]!)
}

for v in l {
    print(v)
}



