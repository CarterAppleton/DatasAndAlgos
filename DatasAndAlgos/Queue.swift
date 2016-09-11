//
//  Queue.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/10/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

struct Queue<Item> {
    
    /// Array for the queue
    private var queue: [Item] = [Item]()
    
    /**
     
     Initialize a Queue with the given item.
     
     - returns:
     A Queue with the given item.
     
     - parameters:
        - item: Item to add to the Queue
     */
    init(_ item: Item) {
        self.enqueue(item)
    }
    
    /**
     
     Initialize a Queue with the given items.
     
     - returns:
     A Queue with the given items.
     
     - parameters:
        - item: Items to add to the Queue. Will be added in order of array.
     */
    init<S : SequenceType where S.Generator.Element == Item>(_ items: S) {
        self.enqueue(items)
    }
    
    /**
     
     Add an item to the back of the Queue.
     
     - parameters:
        - item: Item to add to the Queue.
     */
    mutating func enqueue(item: Item) {
        self.queue.append(item)
    }
    
    /**
     
     Add items to the back of the Queue.
     
     - parameters:
        - items: Items to add to the Queue. Will be added in the order that the sequence dictates.
     */
    mutating func enqueue<S : SequenceType where S.Generator.Element == Item>(items: S) {
        for item in items {
            self.enqueue(item)
        }
    }
    
    /**
     
     Remove the front item from the Queue, if it exists.
     
     - returns:
    The front item in the Queue, or nil if it doesn't exist.
     */
    mutating func dequeue() -> Item? {
        if let first = self.queue.first {
            self.queue.removeFirst()
            return first
        }
        return nil
    }
    
    /**
     
     See the front item from the Queue, if it exists.
     
     - returns:
    The front item in the Queue, or nil if it doesn't exist.
     */
    func peek() -> Item? {
        return self.queue.first
    }
    
}
