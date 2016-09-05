//
//  Heap.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

/**
 
 Type of Heaps that can be created.
 
 * Min: Min heap where the minimum element will be at the top
 * Max: Max heap where the maximum element will be at the top

 */
enum HeapType<E: Comparable> {
    
    case Min, Max
    
    func comparison() -> ((E, E) -> Bool) {
        switch self {
        case .Min:
            return {$0 < $1}
        case .Max:
            fallthrough
        default:
            return {$0 > $1}
        }
    }
}

struct Heap<E: Comparable> {
    
    /// Comparison function the heap is based on
    private var comparison: ((E, E) -> Bool)!
    
    /// Array used to hold elements of the heap
    private var heap: [E] = [E]()
    
    /**
     
     Initialize an empty heap with a default comparison function.
     
     - returns:
     An empty heap.
     
     - parameters:
        - type: The type of heap to create, either Min or Max.
     */
    init(type: HeapType<E>) {
        self.comparison = type.comparison()
    }
    
    /**
     
     Initialize a heap with a default comparison function, filled with elements.
     
     - returns:
     A heap filled with the elements in arr.
     
     - parameters:
        - arr: Elements to initialize the heap with.
        - type: The type of heap to create, either Min or Max.
     */
    init<S : SequenceType where S.Generator.Element == E>(_ items: S, type: HeapType<E>) {
        self.comparison = type.comparison()
        self.insert(items)
    }
    
    /**
     
     Insert an item into the heap.
     
     - parameters:
        - item: The item to insert in the heap.
     */
    mutating func insert(item: E) {
        heap += [item]
        self.percolateUp(heap.count - 1)
    }
    
    /**
     
     Insert an array of items into the heap.
     
     - parameters:
        - items: The items to insert in the heap.
     */
    mutating func insert<S : SequenceType where S.Generator.Element == E>(items: S) {
        for item in items {
            self.insert(item)
        }
    }
    
    /**
     
     View the top most item in the heap. Top will be the min or max of all items in the heap, depending on the heap type.
     
     - returns:
     Top most item in the heap, if it exists. Nil if the heap is empty.
     */
    func peek() -> E? {
        return self.heap.first
    }
    
    /**
     
     Remove and return the top most item in the heap. Top will be the min or max of all items in the heap, depending on the heap type.
     
     - returns:
     Top most item in the heap, if it exists. Nil if the heap is empty.
     */
    mutating func pop() -> E? {
        if let top = self.heap.first {
            if self.heap.count == 1 {
                self.heap = [E]()
            } else {
                self.heap[0] = self.heap.removeLast()
                self.percolateDown(0)
            }
            return top
        }
        return nil
    }
    
    /**
     
     An array of items in the heap, sorted by the heap's comparison function.
     
     - returns:
     Sorted array of all items in the heap.
     */
    private func array() -> [E] {
        var arr = [E]()
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
    typealias Generator = AnyGenerator<E>
    
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
