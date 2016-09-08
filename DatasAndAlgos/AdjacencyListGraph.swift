//
//  AdjacencyListGraph.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/6/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

import Foundation

struct AdjacencyListGraph<E: Hashable> : Graph {
    typealias T = E
    
    /// [Vertex -> [Vertex -> Weight]]
    private var adjacencyList: [E : [E : Int]] = [E : [E : Int]]()
    
    /// Directed or not
    var undirected: Bool = true
    
    /**
     
     Initialize an empty AdjacencyListGraph.
     
     - returns:
     An empty AdjacencyListGraph.
     
     - parameters:
        - directed: Whether or not the edges is directed
     */
    init(undirected: Bool) {
        self.undirected = undirected
    }
    
    /**
     
     Initialize an AdjacencyListGraph with the given vertices.
     
     - returns:
     An AdjacencyListGraph filled with vertices that is directed or undirected.
     
     - parameters:
        - directed: Whether or not the edges are directed
        - vertices: Vertices that should be in the graph.
     */
    init(undirected: Bool, withVertices vertices: [E]) {
        self.undirected = undirected
        self.add(vertices: vertices)

    }
    
    /**
     
     Adds a vertex to the graph.
     
     - parameters:
        - vertex: Vertex to be added.
     */
    mutating func add(vertex vertex: E) {
        if self.adjacencyList[vertex] == nil {
            self.adjacencyList[vertex] = [E : Int]()
        }
    }
    
    /**
     
     Adds multiple vertices to the graph.
     
     - parameters:
        - vertices: Vertices to be added.
     */
    mutating func add(vertices vertices: [E]) {
        for vertex in vertices {
            self.add(vertex: vertex)
        }
    }
    
    /**
     
     Removes a vertex from the graph, if it exists.
     
     - returns:
     True if exists (always removed on existence), false otherwise.
     
     - parameters:
        - vertex: Vertex to be removed.
     */
    mutating func remove(vertex vertex: E) -> Bool {
        if self.remove(edgesToVertex: vertex) {
            self.adjacencyList[vertex] = nil
            return true
        }
        return false
    }
    
    /**
     
     Add an edge to the graph. Edges are defined as tuples (a,b,w) such that
     a is the origin, b is the endpoint, and w is the weight.
     
     - returns:
     True if both the origin and endpoint vertex exist.
     
     - parameters:
        - fromVertex: Origin vertex of the edge.
        - toVertex: Endpoint vertex of the edge.
        - weight: Weight of the edge
     */
    mutating func add(edgeFromVertex fromVertex: E, toVertex: E, withWeight weight: Int) -> Bool {
        if self.adjacencyList[fromVertex] != nil && self.adjacencyList[toVertex] != nil {
            self.adjacencyList[fromVertex]![toVertex] = weight
            if self.undirected {
                self.adjacencyList[toVertex]![fromVertex] = weight
            }
            return true
        }
        return false
    }
    
    /**
     
     Adds multiple edges to the graph.
     
     - returns:
     True if every origin and endpoint vertex exist.
     
     - parameters:
        - edges: Edges to add to the graph. Edges are defined as tuples (a,b,w) such that
     a is the origin, b is the endpoint, and w is the weight.
     */
    mutating func add(edges edges: [GraphEdge<E>]) -> Bool {
        
        // First check that all vertices exist
        for edge in edges {
            if self.adjacencyList[edge.originVertex] == nil || self.adjacencyList[edge.targetVertex] == nil {
                return false
            }
        }
        
        // Then add all of the edges to the graph
        for edge in edges {
            self.add(edgeFromVertex: edge.originVertex, toVertex: edge.targetVertex, withWeight: edge.weight)
        }
        return true
    }
    
    /**
     
     Removes an edge from the graph, if it exists.
     
     - returns:
     True if exists (always removed on existence), false otherwise.
     
     - parameters:
        - fromVertex: Vertex the edge starts at
        - toVertex: Vertex the edge ends at
     */
    mutating func remove(edgeFromVertex fromVertex: E, toVertex: E) -> Bool {
        if let _ = self.adjacencyList[fromVertex], let _ = self.adjacencyList[toVertex] {
            self.adjacencyList[fromVertex]![toVertex] = nil
            if self.undirected {
                self.adjacencyList[toVertex]![fromVertex] = nil
            }
            return true
        }
        return false
    }
    
    /**
     
     Removes all edges originating from the vertex, if the vertex exists.
     
     - returns:
     True if the vertex exists (all edges always removed on existence), false otherwise.
     
     - parameters:
        - vertex: Vertex to remove all edges from
     */
    mutating func remove(edgesFromVertex vertex: T) -> Bool {
        if let _ = self.adjacencyList[vertex] {
            self.adjacencyList[vertex] = nil
            return true
        }
        return false
    }
    
    /**
     
     Removes all edges pointing to a vertex, if the vertex exists
     
     - returns:
     True if the vertex exists (all edges always removed on existence), false otherwise.
     
     - parameters:
        - vertex: Vertex to remove all edges pointing to
     */
    mutating func remove(edgesToVertex vertex: E) -> Bool {
        if let edges = self.edges(toVertex: vertex) {
            for edge in edges {
                self.remove(edgeFromVertex: edge.originVertex, toVertex: vertex)
            }
            return true
        }
        return false
    }
    
    /**
     
     Add vertices and edges to the graph. Edges must all have valid origin and
     endpoint vertices or only the vertices will be added.
     
     - returns:
     True if all edges and vertices added, false otherwise. Only false if edges
     contain vertices not in the graph (including new vertices); on failure only
     vertices are added.
    
     - parameters:
        - vertices: Vertices to add
        - edges: Edges to add
     */
    mutating func add(vertices vertices: [T], withEdges edges: [GraphEdge<E>]) -> Bool {
        self.add(vertices: vertices)
        return self.add(edges: edges)
    }
    
    /**
     
     Returns an arbitrary, but not necessarily random, vertex from the graph.
     
     - returns:
     Arbitrary vertex in the graph.
     */
    func anyVertex() -> E? {
        return adjacencyList.keys.first
    }
    
    /**
     
     All vertices in the graph.
     
     - returns:
     All vertices.
     */
    func vertices() -> [E] {
        return Array(adjacencyList.keys)
    }
    
    /**
     
     All vertices adjacent (in the neighborhood) of the given vertex.
     
     - returns:
     All vertices one edge away from the given vertex.
     
     - parameters:
        - vertex: Origin vertex
     */
    func vertices(adjacentTo vertex: E) -> [E]? {
        if let edges = self.adjacencyList[vertex] {
            return edges.reduce([E](), combine: { $0 + [$1.0]})
        }
        return nil
    }
    
    /**
     
     All edges in the graph.
     
     - returns:
     All edges.
     */
    func edges() -> [GraphEdge<E>] {
        var allEdges = [GraphEdge<E>]()
        for (vertex, _) in self.adjacencyList {
            allEdges += self.edges(fromVertex: vertex)!
        }
        return allEdges
    }
    
    /**
     
     All edges originating from a vertex. Edges are defined as tuples (a,b,w) 
     such that a is the origin, b is the endpoint, and w is the weight.
     
     - returns:
     All edges from a vertex.
     
     - parameters:
        - vertices: Vertex for the edges to originate from.
     */
    func edges(fromVertex vertex: E) -> [GraphEdge<E>]? {
        var edges = [GraphEdge<E>]()
        if let startVertexEdges = self.adjacencyList[vertex] {
            edges = startVertexEdges.reduce([], combine: { $0 + [GraphEdge(origin: vertex, target: $1.0, weight: $1.1)] })
            return edges
        }
        return nil
    }
    
    /**
     
     All edges pointing to a vertex. Edges are defined as tuples (a,b,w) such 
     that a is the origin, b is the endpoint, and w is the weight.
     
     - returns:
     All edges pointing to the vertex.
     
     - parameters:
        - vertices: Vertex for the edges to point to.
     */
    func edges(toVertex vertex: E) -> [GraphEdge<E>]? {
        if let _ = self.adjacencyList[vertex] {
            var allEdges = [GraphEdge<E>]()
            for edge in self.edges() {
                if edge.targetVertex == vertex {
                    allEdges.append(edge)
                }
            }
            return allEdges
        }
        return nil
    }
    
}