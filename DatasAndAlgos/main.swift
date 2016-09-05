//
//  main.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
var h = Heap(arr: [1,2,3,6,77,8,4,23,4,5677,89], type: .Min)

print(Array(h))

for v in h {
    print(v)
}
 */

/*(
var s = SplayTree(item: 1)
print(Array(s))
s = s.insert(2)
print(Array(s))
s = s.insert(3)
print(Array(s))
s = s.insert(5)
print(Array(s))
s = s.insert(3)
print(Array(s))
 */

var s = SplayTree(item: 2)
print(s.treeOrder(s))
s = s.insert(1)
print(s.treeOrder(s))
s = s.insert(2)
print(s.treeOrder(s))

s = s.insert(2)
print(s.treeOrder(s))
s = s.insert(5)
print(s.treeOrder(s))
s = s.insert(0)
print(s.treeOrder(s))
s = s.insert(3)
print(Array(s))