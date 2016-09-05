//
//  main.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

import Foundation

print("Hello, World!")

let d: HeapType<Int> = .Max

var h = Heap(arr: [1,2,3,6,77,8,4,23,4,5677,89], type: d)
print(h.array())