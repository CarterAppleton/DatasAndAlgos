//
//  RadixSort.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

extension _ArrayType where Generator.Element == Int {
    
    func radixSort() -> [Int] {
        
        func radixSort(arr: [Int], max: Int, exponent: Int) -> [Int] {
            var positions = Array(count: 10, repeatedValue: 0)
            var out = Array(count: arr.count, repeatedValue: 0)
            
            for n in arr {
                positions[(n / exponent) % 10] += 1
            }
            
            for i in 1..<positions.count {
                positions[i] += positions[i - 1]
            }
            
            for i in (arr.count - 1).stride(through: 0, by: -1) {
                let n = arr[i]
                out[positions[(n / exponent) % 10] - 1] = n
                positions[(n / exponent) % 10] -= 1
            }
            
            return out
        }
        
        if let max = self.maxElement() {
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