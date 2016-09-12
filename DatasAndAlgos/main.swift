//
//  main.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

print("Hello, Daily Data Structures and Algorithms!")
print("")

let emptyArray = [Int]()
let singleArray = [1]
let smallArray = [1,3,2]
let smallArray2 = [1,-3,2]
let increasingArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
let decreasingArray: [Int] = increasingArray.reverse()
let largeArray = [1,2,3,6,77,8,4,23,4,5677,89,34,5,7765,345,2,34,45,56,457,6,8,5,456,432,3,4,5,56,7,64,32,1,21,1,2,3,4,45,7,3]
let largeArraySorted = [1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6, 6, 7, 7, 8, 8, 21, 23, 32, 34, 34, 45, 45, 56, 56, 64, 77, 89, 345, 432, 456, 457, 5677, 7765]
let largeArrayUnique = [1, 2, 3, 4, 5, 6, 7, 8, 21, 23, 32, 34, 45, 56, 64, 77, 89, 345, 432, 456, 457, 5677, 7765]

// Splay Tree

var h1 = Heap(comparison: <, withItems: emptyArray)
var h2 = Heap(comparison: <, withItems: singleArray)
var h3 = Heap(comparison: <, withItems: smallArray)
var h4 = Heap(comparison: <, withItems: smallArray2)
var h5 = Heap(comparison: <, withItems: increasingArray)
var h6 = Heap(comparison: <, withItems: decreasingArray)
var h7 = Heap(comparison: <, withItems: largeArraySorted)

let heapTestCases = [
    (Array(h1) == [], true),
    (Array(h2) == singleArray, true),
    (Array(h3) == [1,2,3], true),
    (Array(h4) == [-3,1,2], true),
    (Array(h5) == increasingArray, true),
    (Array(h6) == increasingArray, true)
]
testFunction("Heap", inputs: heapTestCases)


let s1 = SplayTree(emptyArray)
let s2 = SplayTree(singleArray)
let s3 = SplayTree(smallArray)
let s4 = SplayTree(smallArray2)
let s5 = SplayTree(increasingArray)
let s6 = SplayTree(decreasingArray)
let s7 = SplayTree(largeArraySorted)

let splayTreeTestCases = [
    (Array(s1) == [], true),
    (Array(s2) == singleArray, true),
    (Array(s3) == [1,2,3], true),
    (Array(s4) == [-3,1,2], true),
    (Array(s5) == increasingArray, true),
    (Array(s6) == increasingArray, true)
]
testFunction("Splay Tree", inputs: splayTreeTestCases)


let mergeSortTestCases = [
    (emptyArray.mergeSort() == [], true),
    (singleArray.mergeSort() == singleArray, true),
    (smallArray.mergeSort() == [1,2,3], true),
    (smallArray2.mergeSort() == [-3,1,2], true),
    (increasingArray.mergeSort() == increasingArray, true),
    (decreasingArray.mergeSort() == increasingArray, true),
    (largeArray.mergeSort() == largeArraySorted, true)
]
testFunction("Merge Sort", inputs: mergeSortTestCases)

let radixSortTestCases = [
    (emptyArray.radixSort() == [], true),
    (singleArray.radixSort() == singleArray, true),
    (smallArray.radixSort() == [1,2,3], true),
    (increasingArray.radixSort() == increasingArray, true),
    (decreasingArray.radixSort() == increasingArray, true),
    (largeArray.radixSort() == largeArraySorted, true)
]
testFunction("Radix Sort", inputs: radixSortTestCases)


/*
 
 Testing Graph
 
 */

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


var graphA: AdjacencyListGraph<String> = AdjacencyListGraph()
graphA.add(vertices: ["a","b","c","d","e","f"],
          withEdges: [
            GraphEdge(origin: "a", target: "b", weight: 2),
            GraphEdge(origin: "a", target: "c", weight: 4),
            GraphEdge(origin: "b", target: "c", weight: 5),
            GraphEdge(origin: "b", target: "e", weight: 1),
            GraphEdge(origin: "c", target: "e", weight: 3),
            GraphEdge(origin: "c", target: "d", weight: 7)
    ])
//print(graphA.vertices())
//print(graphA.edges())

/*
 
 Graph B:
 
    1    1    1    1
 a -- b -- c -- d -- e
  \                 /
   -----------------
           10
 */

var graphB: AdjacencyListGraph<String> = AdjacencyListGraph()
graphB.add(vertices: ["a","b","c","d","e","f"],
           withEdges: [
            GraphEdge(origin: "a", target: "b", weight: 1),
            GraphEdge(origin: "b", target: "c", weight: 1),
            GraphEdge(origin: "c", target: "d", weight: 1),
            GraphEdge(origin: "d", target: "e", weight: 1),
            GraphEdge(origin: "a", target: "e", weight: 10)
    ])
//print(graphA.vertices())
//print(graphA.edges())

/*
 
 Testing Kruskal's Algorithm
 
 */

var graphAMinSpanningTree = try graphA.minimumSpanningTree()
var graphBMinSpanningTree = try graphB.minimumSpanningTree()

let minSpanningTreeTestCases = [
    (graphAMinSpanningTree.vertices().count == graphA.vertices().count, true),
    (graphAMinSpanningTree.edges().count == 4,true),
    (graphAMinSpanningTree.edges().map({ $0.weight }).sum() == 13,true),
    (graphBMinSpanningTree.vertices().count == graphB.vertices().count, true),
    (graphBMinSpanningTree.edges().count == 4,true),
    (graphBMinSpanningTree.edges().map({ $0.weight }).sum() == 4,true),
]
testFunction("Kruskal's Algorithm", inputs: minSpanningTreeTestCases)


/*
 
 Testing DFS
 
 */
let dfsTestCases = [
    (graphA.depthFirstSearch("a"),true),
    (graphA.depthFirstSearch("b"),true),
    (graphA.depthFirstSearch("f"),true),
    (graphA.depthFirstSearch("d"),true),
    (graphA.depthFirstSearch("g"),false),
    (graphB.depthFirstSearch("a"),true)
]
testFunction("Depth First Search", inputs: dfsTestCases)

/*
 
 Testing BFS
 
 */
let bfsTestCases: [([String]?,[String]?)] = [
    (graphA.breadthFirstSearch(forVertex: "a", startingAt: "d"),["d","c","a"]),
    (graphA.breadthFirstSearch(forVertex: "c", startingAt: "a"),["a","c"]),
    (graphA.breadthFirstSearch(forVertex: "a", startingAt: "e"),["e","b","a"]),
    (graphA.breadthFirstSearch(forVertex: "e", startingAt: "a"),["a","b","e"]),
    (graphB.breadthFirstSearch(forVertex: "e", startingAt: "a"),["a","e"]),
    (graphA.breadthFirstSearch(forVertex: "a", startingAt: "f"),nil),
    (graphA.breadthFirstSearch(forVertex: "g", startingAt: "a"),nil),
    (graphA.breadthFirstSearch(forVertex: "g", startingAt: "h"),nil)
]
testFunction("Breadth First Search", inputs: bfsTestCases)

/*
 
 Testing Dijkstra
 
 */
let dijkstraTestCases: [([GraphEdge<String>]?,[GraphEdge<String>]?)] = [
    (graphB.shortestPath(fromVertex: "a", toVertex: "d")!,[GraphEdge(origin: "a", target: "b", weight: 1),
                                                           GraphEdge(origin: "b", target: "c", weight: 1),
                                                           GraphEdge(origin: "c", target: "d", weight: 1)]),
    (graphB.shortestPath(fromVertex: "a", toVertex: "e")!,[GraphEdge(origin: "a", target: "b", weight: 1),
                                                           GraphEdge(origin: "b", target: "c", weight: 1),
                                                           GraphEdge(origin: "c", target: "d", weight: 1),
                                                           GraphEdge(origin: "d", target: "e", weight: 1)]),
    (graphB.shortestPath(fromVertex: "a", toVertex: "f"),nil)
]
testFunction("Dijkstra's Algorithm", inputs: dijkstraTestCases)

/*
 
 Testing Trie
 
 */
var trie = Trie(["Hello","Daily","Data","Structures"])
let trieTestCases = [
    (trie.contains("Hello"),true),
    (trie.contains("World"),false),
    (trie.contains(""),false),
    (trie.contains("Dail"),false),
    (trie.contains("Struc"),false),
    (trie.contains("Structurese"),false),
    (trie.contains("Structures"),true),
    (trie.contains("Structures"),true),
    (trie.allWords().description == "[\"Hello\", \"Data\", \"Daily\", \"Structures\"]",true)
]
testFunction("Trie", inputs: trieTestCases)





