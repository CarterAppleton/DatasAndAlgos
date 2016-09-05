//
//  RadixSort.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

/**
 
 Extend Arrays that contain integers so they support RadixSort
 
 */
extension _ArrayType where Generator.Element == Int {
    
    /**
     
     Return an Array of the sorted items of source.
     
     - returns:
     Sorted array of source.
     */
    func radixSort() -> [Int] {
        
        /// Sort the integers by the given place (exponent). Respects previous 
        ///  ordering by lower places.
        func radixSort(arr: [Int], max: Int, exponent: Int) -> [Int] {
            var positions = Array(count: 10, repeatedValue: 0)
            var out = Array(count: arr.count, repeatedValue: 0)
            
            // For their value given place, count how many integers are in 
            //  each bucket
            for n in arr {
                positions[(n / exponent) % 10] += 1
            }
            
            // Add each previous bucket's count to the next
            for i in 1..<positions.count {
                positions[i] += positions[i - 1]
            }
            
            // Loop through arr backwards, and insert at each bucket's count.
            //  Decrement the bucket's count at each insertion so it always 
            //  points to an empty space
            for i in (arr.count - 1).stride(through: 0, by: -1) {
                let n = arr[i]
                out[positions[(n / exponent) % 10] - 1] = n
                positions[(n / exponent) % 10] -= 1
            }
            
            return out
        }
        
        if let max = self.maxElement() {
            // Sort by each exponent, increasing until we've hit the max
            var exponent = 1
            var arr: [Int] = self as! [Int]
            while max / exponent > 0 {
                arr = radixSort(arr, max: max, exponent: exponent)
                exponent *= 10
            }
            return arr
        }
        
        return []
    }
    
}