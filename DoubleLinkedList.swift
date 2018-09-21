/*
DoubleLinkedList.swift
Created by Landon Marchant on 7/12/17.
All types start with Capital letters, like Int, T, String
*/

import Foundation

/// Class Node takes any type, and builds nodes for a doubly linked list. 

class DoubleNode<T> {
    ///
    /// - Parameters:
    ///    - next: the node being built
    ///    - prev: previous. next - 1
    ///    - data: what the node contains, takes any type. Optional because dummy nodes have to be nil
    
    fileprivate var next: DoubleNode<T>?
    fileprivate var prev: DoubleNode<T>?
    fileprivate var data: T?
    
    init(_ value: T? = nil, with head: DoubleNode<T>? = nil, with tail: DoubleNode<T>? = nil) {
        data = value
        next = tail
        prev = head

    }
    /// returns the length of the list
}
class DoubleLinkedList<T>: Sequence {
    // head is not optional because the dummy modes are always there. always have a head
    fileprivate var head: DoubleNode<T>
    fileprivate var tail: DoubleNode<T>
    
    init() {
        // dummy node
        head = DoubleNode<T>()
        tail = DoubleNode<T>()
        head.next = tail
        tail.prev = head
    }
    var isEmpty: Bool {
        return tail.prev! === head
    }
    var first: T? {
        if isEmpty {
            return nil
        }
        else {
            return head.next!.data!
        }
    }
    var last: T? {
        if isEmpty {
            return nil
        }
        else {
            return tail.prev!.data!
        }
    }
    func add(_ value: T) {
        let NewNode = DoubleNode<T>(value)
        NewNode.next = head.next
        NewNode.prev = head
        head.next!.prev = NewNode
        head.next = NewNode
        
    }
    func append(_ value: T) {
        let NewNode = DoubleNode<T>(value)
        NewNode.prev = tail.prev
        NewNode.next = tail
        tail.prev!.next = NewNode
        tail.prev = NewNode
    }
    var count: Int {
        var finger = head.next!
        var result = 0
        // if finger not === tail
        while !(finger === tail) {
            result += 1
            finger = finger.next!
        }
        return result
    }
    func makeIterator() -> DoubleLinkedListIterator<T> {
        return DoubleLinkedListIterator<T>(self)
    }
/*
    func popFirst() {
        let removedNode = target.head.next
        
        target.head.next = target.head.next!.prev!
        target.head = removedNode!.prev!
        target.head.next = removedNode!.next
        //return removedNode
    }
     func popLast {
     undoes append
     }
 */
}
class DoubleLinkedListIterator<T>: IteratorProtocol {
    var target: DoubleLinkedList<T>
    var finger: DoubleNode<T>
    init(_ target: DoubleLinkedList<T>) {
        self.target = target
        // head points to dummy node, next points to first actual value
        finger = target.head.next!
    }
    func next() -> T? {
        if finger === target.tail {
            return nil
        }
        else {
            let result = finger.data!
            finger = finger.next!
            return result
        }
    }

}

var l = DoubleLinkedList<Int>()
l.add(3)
l.add(5)
l.append(10)
print(l.isEmpty)
print(l.count)
print(l.first!)
print(l.last!)
print(l.popFirst()!)

// now we're using a for loop so class needs to be Sequence
for v in l {
    print(v)
}
