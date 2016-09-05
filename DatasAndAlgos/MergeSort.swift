//
//  MergeSort.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

/**
 
 Extend Array so it supports MergeSort
 
 */
extension Array where Element : Comparable {
    
    /**
     
     Return an Array of the sorted items of source.
     
     - returns:
     Sorted array of source.
     */
    func mergeSort() -> [Element] {
        
        /// Merge two arrays with respect to ordering
        func mergeSortedArrays(one: [Element], _ two: [Element]) -> [Element] {
            var (l, r) = (0, 0)
            var ret = [Element]()
            
            // While both arrays have elements, add the next lowest element
            while l < one.count && r < two.count {
                
                let left: Element = one[l]
                let right: Element = two[r]
                
                if left < right {
                    ret += [left]
                    l += 1
                } else {
                    ret += [right]
                    r += 1
                }
            }
            
            // Add whatever is remaining, either one array will have elements or none will
            ret += one.dropFirst(l)
            ret += two.dropFirst(r)
            
            return ret
        }
        
        func mergeSort(arr: [Element]) -> [Element] {
            
            // If the array is only one element or less it's sorted
            if arr.count < 2 {
                return arr
            }
            
            // Split the array in two
            let left = Array(arr[0..<(arr.count / 2)])
            let right = Array(arr[(arr.count / 2)..<arr.count])
            
            // Sort both sides
            let leftSorted: [Element] = mergeSort(left)
            let rightSorted: [Element] = mergeSort(right)
            
            // Combine arrays, keeping them sorted, and return
            return mergeSortedArrays(leftSorted, rightSorted)
        }
        
        return mergeSort(self)
    }
    
}