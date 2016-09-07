//
//  GraphProtocol.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/6/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

struct GraphEdge<E: Hashable> : Comparable {
    var originVertex: E
    var targetVertex: E
    var weight: Int
    init(origin: E, target: E, weight: Int) {
        self.originVertex = origin
        self.targetVertex = target
        self.weight = weight
    }
}

func ==<T>(lhs: GraphEdge<T>, rhs: GraphEdge<T>) -> Bool {
    return lhs.weight == rhs.weight
}

func <<T>(lhs: GraphEdge<T>, rhs: GraphEdge<T>) -> Bool {
    return lhs.weight < rhs.weight
}

protocol Graph {
    associatedtype T : Hashable
    
    /// Whether or not the graph is directed
    var undirected: Bool { get }
    
    /// Initialize as directed or not
    init(undirected: Bool)
    
    /// Initialize as directed or not with vertices
    init(undirected: Bool, withVertices vertices: [T])
    
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