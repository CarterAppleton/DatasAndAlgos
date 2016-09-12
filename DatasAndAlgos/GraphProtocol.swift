//
//  GraphProtocol.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/6/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

protocol Graph {
    associatedtype T : Hashable
    
    /// Whether or not the graph is directed
    var directed: Bool { get }
    
    /// Initialize as directed or not
    init(directed: Bool)
    
    /// Initialize as directed or not with vertices
    init(directed: Bool, withVertices vertices: [T])
    
    /// Add a vertex
    mutating func add(vertex vertex: T)
    /// Add multiple vertices
    mutating func add(vertices vertices: [T])
    /// Remove a vertex
    /// True if the vertex existed, false if no such vertex in graph
    mutating func remove(vertex vertex: T) -> Bool
    
    
    /// Add an edge with given weight
    mutating func add(edgeFromVertex fromVertex: T, toVertex: T, withWeight weight: Int) -> Bool
    /// Add multiples edges with weights
    mutating func add(edges edges: [GraphEdge<T>]) -> Bool
    /// Remove a given edge
    /// True if the edge existed, false if no such edge in graph
    mutating func remove(edgeFromVertex fromVertex: T, toVertex: T) -> Bool
    /// Remove all edges originating from a given vertex
    /// True if the vertex existed, false if no such vertex in graph
    mutating func remove(edgesFromVertex vertex: T) -> Bool
    /// Remove all edges pointing to a given vertex
    /// True if the vertex existed, false if no such vertex in graph
    mutating func remove(edgesToVertex vertex: T) -> Bool
    
    
    /// Add multiple vertices and edges
    mutating func add(vertices vertices: [T], withEdges edges: [GraphEdge<T>]) -> Bool
    
    /// Any vertex in the graph
    func anyVertex() -> T?
    /// All vertices
    func vertices() -> [T]
    /// All vertices adjacent to a given vertex
    /// Array of adjacent vertices, nil if no such origin vertex exists
    func vertices(adjacentTo vertex: T) -> [T]?
    
    
    /// All edges
    func edges() -> [GraphEdge<T>]
    /// All edges originating from a given vertex
    /// Array of edges, nil if no such origin vertex exists
    func edges(fromVertex vertex: T) -> [GraphEdge<T>]?
    /// All edges pointing to a given vertex
    /// Array of edges, nil if no such vertex exists
    func edges(toVertex vertex: T) -> [GraphEdge<T>]?
}


/// Graph Edge- Comparable by weight to other edges and printable to console
struct GraphEdge<E: Hashable> : Comparable, Hashable, CustomStringConvertible {
    
    /// The origin of the edge, or one endpoint on an undirected graph
    var originVertex: E
    
    /// The target of the edge, or one endpoint on an undirected graph
    var targetVertex: E
    
    /// The weight of the edge, or 0 if unweighted
    var weight: Int
    
    /// Hashvalue
    var hashValue: Int {
        return originVertex.hashValue ^ targetVertex.hashValue ^ weight.hashValue
    }
    
    /// Initialize an unweighted edge
    init(origin: E, target: E) {
        self.originVertex = origin
        self.targetVertex = target
        self.weight = 0
    }
    
    /// Initialize a weighted edge
    init(origin: E, target: E, weight: Int) {
        self.originVertex = origin
        self.targetVertex = target
        self.weight = weight
    }
    
    /// Description of the edge, in the form (origin: , target: , weight: )
    var description: String {
        return "(o: \(originVertex), t: \(targetVertex), w: \(weight))"
    }
}

/// Compare weight of two Graph Edges, True if their weights are the same
func ==<T>(lhs: GraphEdge<T>, rhs: GraphEdge<T>) -> Bool {
    return lhs.weight == rhs.weight
        && lhs.originVertex == rhs.originVertex
        && lhs.targetVertex == rhs.targetVertex
}

/// Compare weight of two Graph Edges, True if left is lighter than right
func <<T>(lhs: GraphEdge<T>, rhs: GraphEdge<T>) -> Bool {
    return lhs.weight < rhs.weight
}