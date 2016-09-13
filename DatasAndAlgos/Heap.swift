//
//  Heap.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/12/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

protocol Heap {
    associatedtype Element
    
    /// Initialize with a comparison function
    init(comparison: ((Element, Element) -> Bool))
    
    /// Initialize with a comparison function and items
    init<S : SequenceType where S.Generator.Element == Element>(comparison: ((Element, Element) -> Bool), withItems items: S)
    
    /// Add an item
    mutating func insert(item: Element)
    /// Add multiple items
    mutating func insert<S : SequenceType where S.Generator.Element == Element>(items: S)
    
    /// View the top item in the heap
    func top() -> Element?
    
    /// Remove the top item in the heap
    mutating func pop() -> Element?
}