//
//  Heap.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

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
    
    private var comparison: ((E, E) -> Bool)!
    private var heap: [E] = [E]()
    private var nextIndex: Int = 0
    
    init(comparison: ((E, E) -> Bool)) {
        self.comparison = comparison
    }
    
    init(type: HeapType<E>) {
        self.comparison = type.comparison()
    }
    
    init(arr: [E], type: HeapType<E>) {
        self.comparison = type.comparison()
        self.insert(arr)
    }
    
    init(arr: [E], comparison: ((E, E) -> Bool)) {
        self.comparison = comparison
        self.insert(arr)
    }
    
    mutating func insert(item: E) {
        heap += [item]
        self.percolateUp(heap.count - 1)
    }
    
    mutating func insert(array: [E]) {
        for item in array {
            self.insert(item)
        }
    }
    
    func peek() -> E? {
        return self.heap.first
    }
    
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
    
    func array() -> [E] {
        var arr = [E]()
        var h = self
        while let next = h.pop() {
            arr += [next]
        }
        return arr
    }
    
    mutating private func percolateUp(index: Int) {
        let (child, parent) = (index, index >> 1)
        if comparison(heap[child],heap[parent]) {
            swap(&heap[child], &heap[parent])
            percolateUp(parent)
        }
    }
    
    mutating private func percolateDown(index: Int) {
        
        let (parent, leftChild, rightChild) = (index, index << 1, (index << 1) + 1)
        if let child = chooseChild(leftChild, right: rightChild) {
            if self.comparison(self.heap[child],self.heap[parent]) {
                swap(&heap[child], &heap[parent])
                percolateDown(child)
            }
        }
    }
    
    private func chooseChild(left: Int, right: Int) -> Int? {
        
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
}
