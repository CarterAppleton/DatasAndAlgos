//
//  BinaryHeap.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

struct BinaryHeap<Element> {
    
    /// Comparison function the heap is based on
    private var comparison: ((Element, Element) -> Bool)!
    
    /// Array used to hold elements of the heap
    private var heap: [Element] = [Element]()

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
        heap += [item]
        self.percolateUp(heap.count - 1)
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
        return self.heap.first
    }
    
    /**
     
     Remove and return the top most item in the heap. Top will be the min or max of all items in the heap, depending on the heap type.
     
     - returns:
     Top most item in the heap, if it exists. Nil if the heap is empty.
     */
    mutating func pop() -> Element? {
        
        guard let top = self.heap.first else {
            return nil
        }
        
        if self.heap.count == 1 {
            self.heap = [Element]()
        } else {
            self.heap[0] = self.heap.removeLast()
            self.percolateDown(0)
        }
        
        return top
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
    mutating private func percolateUp(index: Int) {
        let (child, parent) = (index, index >> 1)
        if comparison(heap[child],heap[parent]) {
            swap(&heap[child], &heap[parent])
            percolateUp(parent)
        }
    }
    
    /**
     
     Recursively swaps the given index with its correct child, so long as the comparative function holds and there exists such a child. The correct child is defined as whichever child the comparative function chooses.
     
     - parameters:
        - index: Index of the item to percolate down
     */
    mutating private func percolateDown(index: Int) {
        
        /**
         
         Chooses the correct child's index to swap to. The correct child's index must exist in the heap. If both the left and right children exist, then the comparitive function is used to choose the correct child.
         
         - returns:
         The index of the correct child, if such a child exists. Nil if there are no such children.
         
         - parameters:
         - left: Index of the left child to check
         - right: Index of the right child to check
         */
        func chooseChild(left: Int, right: Int) -> Int? {
            
            if left >= self.heap.count && right >= self.heap.count {
                return nil
            }
            
            if left >= self.heap.count {
                return right
            }
            
            if right >= self.heap.count {
                return left
            }
            
            return self.comparison(self.heap[left], self.heap[right]) ? left : right
        }
        
        let (parent, leftChild, rightChild) = (index, index << 1, (index << 1) + 1)
        if let child = chooseChild(leftChild, right: rightChild) {
            if self.comparison(self.heap[child],self.heap[parent]) {
                swap(&heap[child], &heap[parent])
                percolateDown(child)
            }
        }
    }
}

/**
 
 Extend Heap so it can be:
 * Iterated through in a For-in loop
 * Used to initialize any object taking SequenceType
 
 */
extension Heap : SequenceType {
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
