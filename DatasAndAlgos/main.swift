//
//  main.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

print("Hello, Data Structures and Algorithms!")

let b = [1,2,3,6,77,8,4,23,4,5677,89,34,5,7765,345,2,34,45,56,457,6,8,5,456,432,3,4,5,56,7,64,32,1,21,1,2,3,4,45,7,3]

var s = SplayTree(b)
var h = Heap(b, type: .Min)

print(Array(s))
print(Array(h))
print(b.sort())
print(b.mergeSort())
print(b.radixSort())

