//
//  GraphProtocol.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/6/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

protocol Graph {
    associatedtype T : Equatable
    
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
    mutating func add(edges edges: [(startVertex: T, endVertex: T, weight: Int)]) -> Bool
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
    mutating func add(vertices vertices: [T], withEdges edges: [(startVertex: T, endVertex: T, weight: Int)]) -> Bool
    
    
    /// All vertices
    func vertices() -> [T]
    /// All vertices adjacent to a given vertex
    /// Array of adjacent vertices, nil if no such origin vertex exists
    func vertices(adjacentTo vertex: T) -> [T]?
    
    
    /// All edges
    func edges() -> [(startVertex: T, endVertex: T, weight: Int)]
    /// All edges originating from a given vertex
    /// Array of edges, nil if no such origin vertex exists
    func edges(fromVertex vertex: T) -> [(startVertex: T, endVertex: T, weight: Int)]?
    /// All edges pointing to a given vertex
    /// Array of edges, nil if no such vertex exists
    func edges(toVertex vertex: T) -> [(startVertex: T, endVertex: T, weight: Int)]?
}