//
//  Stack.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/10/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

struct Stack<Item> {
    
    /// Array for the stack
    private var stack: [Item] = [Item]()
    
    /**
     
     Initialize a Stack with the given item.
     
     - returns:
     A Stack with the given item.
     
     - parameters:
        - item: Item to add to the Stack
     */
    init(_ item: Item) {
        self.push(item)
    }
    
    /**
     
     Initialize a Stack with the given items.
     
     - returns:
     A Stack with the given items.
     
     - parameters:
        - item: Items to add to the Stack. Will be added in order of array.
     */
    init<S : SequenceType where S.Generator.Element == Item>(_ items: S) {
        self.push(items)
    }
    
    /**
     
     Add an item to the top of the Stack.
     
     - parameters:
        - item: Item to add to the Stack.
     */
    mutating func push(item: Item) {
        self.stack.append(item)
    }
    
    /**
     
     Add items to the top of the Stack.
     
     - parameters:
        - items: Items to add to the Stack. Will be added in the order that the sequence dictates.
     */
    mutating func push<S : SequenceType where S.Generator.Element == Item>(items: S) {
        for item in items {
            self.push(item)
        }
    }
    
    /**
     
     Remove the top item from the Stack, if it exists.
     
     - returns:
     The top item in the Stack, or nil if it doesn't exist.
     */
    mutating func pop() -> Item? {
        if let last = self.stack.last {
            self.stack.removeLast()
            return last
        }
        return nil
    }
    
    /**
     
     See the top item from the Stack, if it exists.
     
     - returns:
     The top item in the Stack, or nil if it doesn't exist.
     */
    func peek() -> Item? {
        return self.stack.last
    }
    
}