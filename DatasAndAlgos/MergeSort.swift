//
//  MergeSort.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

extension Array where Element : Comparable {
    
    func mergeSort() -> [Element] {
        
        func mergeSort(arr: [Element]) -> [Element] {
            
            if arr.count < 2 {
                return arr
            }
            
            let left = Array(arr[0..<(arr.count / 2)])
            let right = Array(arr[(arr.count / 2)..<arr.count])
            
            let leftSorted: [Element] = mergeSort(left)
            let rightSorted: [Element] = mergeSort(right)
            
            var (l, r) = (0, 0)
            var ret = [Element]()
            while l < leftSorted.count && r < rightSorted.count {
                
                let left: Element = leftSorted[l]
                let right: Element = rightSorted[r]
                
                if left < right {
                    ret += [left]
                    l += 1
                } else {
                    ret += [right]
                    r += 1
                }
            }
            
            if l < leftSorted.count {
                ret += leftSorted.dropFirst(l)
            } else if r < rightSorted.count {
                ret += rightSorted.dropFirst(r)
            }
            
            return ret
        }
        
        return mergeSort(self)
    }
    
}