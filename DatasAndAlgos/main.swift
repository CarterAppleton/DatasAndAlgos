//
//  main.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

print("Hello, Daily Data Structures and Algorithms!")

func testFunction<E: Equatable>(testCase: String, inputs: [([E]?,[E]?)]) {
    print("Starting Testing: \(testCase)")
    var failedCases = ""
    for (index,input) in inputs.enumerate() {
        if let lhs = input.0, let rhs = input.1 {
            if lhs != rhs {
                failedCases += "\(index), "
            }
        } else if input.0 != nil || input.1 != nil {
            failedCases += "\(index), "
        }

    }
    if failedCases != "" {
        print("- FAILED: [\(failedCases.substringToIndex(failedCases.endIndex.predecessor().predecessor()))]")
    } else {
        print("- SUCCESS")
    }

    print("")
}

func testFunction<E: Equatable>(testCase: String, inputs: [(E?,E?)]) {
    print("Starting Testing: \(testCase)")
    var failedCases = ""
    for (index,input) in inputs.enumerate() {
        if let lhs = input.0, let rhs = input.1 {
            if lhs != rhs {
                failedCases += "\(index), "
            }
        } else if input.0 != nil || input.1 != nil {
            failedCases += "\(index), "
        }
        
    }
    if failedCases != "" {
        print("- FAILED: [\(failedCases.substringToIndex(failedCases.endIndex.predecessor().predecessor()))]")
    } else {
        print("- SUCCESS")
    }
    
    print("")
}

func testFunction(testCase: String, inputs: [(Bool,Bool)]) {
    print("Starting Testing: \(testCase)")
    var failedCases = ""
    for (index,input) in inputs.enumerate() {
        if input.0 != input.1 {
            failedCases += "\(index), "
        }
    }
    if failedCases != "" {
        print("- FAILED: [\(failedCases.substringToIndex(failedCases.endIndex.predecessor().predecessor()))]")
    } else {
        print("- SUCCESS")
    }
    
    print("")
}

let b = [1,2,3,6,77,8,4,23,4,5677,89,34,5,7765,345,2,34,45,56,457,6,8,5,456,432,3,4,5,56,7,64,32,1,21,1,2,3,4,45,7,3]

// Splay Tree

var s = SplayTree(b)
var h = Heap(comparison: <, withItems: b)

print(Array(s))
print(Array(h))
print(b.sort())
print(b.mergeSort())
print(b.radixSort())


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

/*
 
 Graph B:
 
    1    1    1    1
 a -- b -- c -- d -- e
  \                 /
   -----------------
           10
 */

var graphB: AdjacencyListGraph<String> = AdjacencyListGraph(undirected: true)
graphB.add(vertices: ["a","b","c","d","e","f"],
           withEdges: [
            GraphEdge(origin: "a", target: "b", weight: 1),
            GraphEdge(origin: "b", target: "c", weight: 1),
            GraphEdge(origin: "c", target: "d", weight: 1),
            GraphEdge(origin: "d", target: "e", weight: 1),
            GraphEdge(origin: "a", target: "e", weight: 10)
    ])
print(graphA.vertices())
print(graphA.edges())

/*
 
 Testing Kruskal's Algorithm
 
 */

var graphAMinSpanningTree = try graphA.minimumSpanningTree()
print(graphAMinSpanningTree.vertices())
print(graphAMinSpanningTree.edges())

/*
 
 Testing DFS
 
 */

print(graphA.depthFirstSearch("a")) // True
print(graphA.depthFirstSearch("b")) // True
print(graphA.depthFirstSearch("f")) // True
print(graphA.depthFirstSearch("d")) // True
print(graphA.depthFirstSearch("g")) // False

/*
 
 Testing BFS
 
 */
print(graphA.breadthFirstSearch(forVertex: "a", startingAt: "d")) // True
print(graphA.breadthFirstSearch(forVertex: "c", startingAt: "a")) // True
print(graphA.breadthFirstSearch(forVertex: "a", startingAt: "e")) // True
print(graphA.breadthFirstSearch(forVertex: "e", startingAt: "a")) // True
print(graphA.breadthFirstSearch(forVertex: "a", startingAt: "f")) // False
print(graphA.breadthFirstSearch(forVertex: "g", startingAt: "a")) // false

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





