//
//  PairingHeap.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/12/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

struct PairingHeap<Element> {
    
    /// Comparison function the heap is based on
    private var comparison: ((Element, Element) -> Bool)!
    
    /// Element this holds, nil if this is the root
    private var element: Element?
    
    /// Array used to hold sibling heaps
    private var subHeaps: [PairingHeap<Element>] = [PairingHeap<Element>]()
    
    /**
     
     Initialize an empty heap with a comparison function.
     
     - returns:
     An empty heap.
     
     - parameters:
     - comparison: Whether an element is larger than the other
     */
    init(comparison: ((Element, Element) -> Bool)) {
        self.comparison = comparison
    }
    
    /**
     
     Initialize a heap with a comparison function, filled with elements.
     
     - returns:
     A heap filled with the elements in arr.
     
     - parameters:
     - comparison: Whether an element is larger than the other
     - arr: Elements to initialize the heap with.
     */
    init<S : SequenceType where S.Generator.Element == Element>(comparison: ((Element, Element) -> Bool), withItems items: S) {
        self.comparison = comparison
        self.insert(items)
    }
    
    /**
     
     Insert an item into the heap.
     
     - parameters:
     - item: The item to insert in the heap.
     */
    mutating func insert(item: Element) {
        
        guard let _ = self.element else {
            self.element = item
            return
        }
        
        let newHeap = merge(lhs: PairingHeap(comparison: self.comparison, withItems: [item]), rhs: self)
        
        self.element = newHeap.element
        self.subHeaps = newHeap.subHeaps
    }
    
    /**
     
     Insert a sequence of items into the heap.
     
     - parameters:
     - items: The items to insert in the heap.
     */
    mutating func insert<S : SequenceType where S.Generator.Element == Element>(items: S) {
        for item in items {
            self.insert(item)
        }
    }
    
    /**
     
     View the top most item in the heap. Top will be the min or max of all items in the heap, depending on the heap type.
     
     - returns:
     Top most item in the heap, if it exists. Nil if the heap is empty.
     */
    func peek() -> Element? {
        return self.element
    }
    
    /**
     
     Remove and return the top most item in the heap. Top will be the min or max of all items in the heap, depending on the heap type.
     
     - returns:
     Top most item in the heap, if it exists. Nil if the heap is empty.
     */
    mutating func pop() -> Element? {
        
        func mergePairs(heaps: [PairingHeap<Element>]) -> PairingHeap<Element>? {
            if heaps.count == 0 {
                return nil
            } else if heaps.count == 1 {
                return heaps[0]
            }
            
            let h: [PairingHeap<Element>] = Array(heaps[1...(heaps.count - 1)])
            return h.reduce(heaps[0], combine: self.merge)
        }
        
        guard let element = self.element else {
            return nil
        }
        
        guard let newHeap = mergePairs(self.subHeaps) else {
            self.element = nil
            return element
        }
        
        self.element = newHeap.element
        self.subHeaps = newHeap.subHeaps
        
        return element
        
    }
    
    /**
     
     An array of items in the heap, sorted by the heap's comparison function.
     
     - returns:
     Sorted array of all items in the heap.
     */
    private func array() -> [Element] {
        var arr = [Element]()
        var h = self
        while let next = h.pop() {
            arr += [next]
        }
        return arr
    }
    
    /**
     
     Recursively swaps the given index with its parent, so long as the comparative function holds and there exists a parent.
     
     - parameters:
     - index: Index of the item to percolate up
     */
    private func merge(lhs lhs: PairingHeap<Element>, rhs: PairingHeap<Element>) -> PairingHeap<Element> {
        
        func addSubHeap(subHeap: PairingHeap<Element>, toHeap heap: PairingHeap<Element>) -> PairingHeap<Element> {
            var returnHeap = heap
            returnHeap.subHeaps += [subHeap]
            return returnHeap
        }
        
        guard let leftElement = lhs.element else {
            return rhs
        }
        
        guard let rightElement = rhs.element else {
            return lhs
        }
        
        if comparison(leftElement,rightElement) {
            return addSubHeap(rhs, toHeap: lhs)
        }
        
        return addSubHeap(lhs, toHeap: rhs)
    }
    
}

/**
 
 Extend Heap so it can be:
 * Iterated through in a For-in loop
 * Used to initialize any object taking SequenceType
 
 */
extension PairingHeap : SequenceType {
    typealias Generator = AnyGenerator<Element>
    
    func generate() -> Generator {
        var index = 0
        var arr = self.array()
        return AnyGenerator {
            if index < arr.count {
                let v = index
                index += 1
                return arr[v]
            }
            return nil
        }
    }
}
