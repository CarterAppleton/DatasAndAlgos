//
//  main.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

print("Hello, Daily Data Structures and Algorithms!")

let b = [1,2,3,6,77,8,4,23,4,5677,89,34,5,7765,345,2,34,45,56,457,6,8,5,456,432,3,4,5,56,7,64,32,1,21,1,2,3,4,45,7,3]

var s = SplayTree(b)
var h = Heap(type: .Min, withItems: b)

print(Array(s))
print(Array(h))
print(b.sort())
print(b.mergeSort())
print(b.radixSort())

/*
 
Graph A:
 
   2
 a -- b
  \   |\      f
 4 \ 5| \ 1
    \ |  \
      c - e
    7 | 3
      d
 
 */

var graphA: AdjacencyListGraph<String> = AdjacencyListGraph(undirected: true)
graphA.add(vertices: ["a","b","c","d","e","f"],
          withEdges: [
            GraphEdge(origin: "a", target: "b", weight: 2),
            GraphEdge(origin: "a", target: "c", weight: 4),
            GraphEdge(origin: "b", target: "c", weight: 5),
            GraphEdge(origin: "b", target: "e", weight: 1),
            GraphEdge(origin: "c", target: "e", weight: 3),
            GraphEdge(origin: "c", target: "d", weight: 7)
    ])
print(graphA.vertices())
print(graphA.edges())

var graphAMinSpanningTree = try graphA.minimumSpanningTree()
print(graphAMinSpanningTree.vertices())
print(graphAMinSpanningTree.edges())

print(graphA.depthFirstSearch("a")) // True
print(graphA.depthFirstSearch("b")) // True
print(graphA.depthFirstSearch("f")) // True
print(graphA.depthFirstSearch("d")) // True
print(graphA.depthFirstSearch("g")) // False

var trie = Trie(["Hello","Daily","Data","Structures"])
print(trie.contains("Hello"))
print(trie.contains("World"))
print(trie.contains(""))
print(trie.allWords())










