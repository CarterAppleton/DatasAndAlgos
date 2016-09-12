//
//  AdjacencyListGraph.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/6/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

import Foundation

struct AdjacencyListGraph<Vertex: Hashable> : Graph {
    
    /// [Vertex -> [Vertex -> Weight]]
    private var adjacencyList: [Vertex : [Vertex : Int]] = [Vertex : [Vertex : Int]]()
    
    /// Directed or not
    private(set) var directed: Bool = false
    
    /**
     
     Initialize an empty AdjacencyListGraph.
     
     - returns:
     An empty AdjacencyListGraph.
     
     - parameters:
        - directed: Whether or not the edges are directed
     */
    init(directed: Bool = false) {
        self.directed = directed
    }
    
    /**
     
     Initialize an AdjacencyListGraph with the given vertices.
     
     - returns:
     An AdjacencyListGraph filled with vertices that is directed or undirected.
     
     - parameters:
        - directed: Whether or not the edges are directed
        - vertices: Vertices that should be in the graph.
     */
    init(directed: Bool = true, withVertices vertices: [Vertex]) {
        self.directed = directed
        self.add(vertices: vertices)

    }
    
    /**
     
     Adds a vertex to the graph.
     
     - parameters:
        - vertex: Vertex to be added.
     */
    mutating func add(vertex vertex: Vertex) {
        if self.adjacencyList[vertex] == nil {
            self.adjacencyList[vertex] = [Vertex : Int]()
        }
    }
    
    /**
     
     Adds multiple vertices to the graph.
     
     - parameters:
        - vertices: Vertices to be added.
     */
    mutating func add(vertices vertices: [Vertex]) {
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
    mutating func remove(vertex vertex: Vertex) -> Bool {
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
    mutating func add(edgeFromVertex fromVertex: Vertex, toVertex: Vertex, withWeight weight: Int) -> Bool {
        
        guard let _ = self.adjacencyList[fromVertex], let _ = self.adjacencyList[toVertex] else {
            return false
        }
        
        self.adjacencyList[fromVertex]![toVertex] = weight
        if !self.directed {
            self.adjacencyList[toVertex]![fromVertex] = weight
        }
        return true
    }
    
    /**
     
     Adds multiple edges to the graph.
     
     - returns:
     True if every origin and endpoint vertex exist.
     
     - parameters:
        - edges: Edges to add to the graph. Edges are defined as tuples (a,b,w) such that
     a is the origin, b is the endpoint, and w is the weight.
     */
    mutating func add(edges edges: [GraphEdge<Vertex>]) -> Bool {
        
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
    mutating func remove(edgeFromVertex fromVertex: Vertex, toVertex: Vertex) -> Bool {
        
        guard let _ = self.adjacencyList[fromVertex], let _ = self.adjacencyList[toVertex] else {
            return false

        }
        
        self.adjacencyList[fromVertex]![toVertex] = nil
        
        if !self.directed {
            self.adjacencyList[toVertex]![fromVertex] = nil
        }
        
        return true
    }
    
    /**
     
     Removes all edges originating from the vertex, if the vertex exists. If 
     Graph is undirected, this is the same as removeEdgesToVertex.
     
     - returns:
     True if the vertex exists (all edges always removed on existence), false otherwise.
     
     - parameters:
        - vertex: Vertex to remove all edges from
     */
    mutating func remove(edgesFromVertex vertex: Vertex) -> Bool {
        
        // Make sure vertex exists
        guard let _ = self.adjacencyList[vertex] else {
            return false
        }
        
        // Remove all edges from this vertex
        self.adjacencyList[vertex] = [Vertex : Int]()
        
        // If undirected, remove all edges to this vertex
        if !self.directed {
            self.remove(edgesToVertex: vertex)
        }
        
        return true
    }
    
    /**
     
     Removes all edges pointing to a vertex, if the vertex exists. If Graph is
     undirected, this is the same as removeEdgesFromVertex.
     
     - returns:
     True if the vertex exists (all edges always removed on existence), false otherwise.
     
     - parameters:
        - vertex: Vertex to remove all edges pointing to
     */
    mutating func remove(edgesToVertex vertex: Vertex) -> Bool {
        
        // Make sure this vertex exists
        guard let edges = self.edges(toVertex: vertex) else {
            return false
        }
        
        // Remove all edges to this vertex (and from if graph is undirected)
        for edge in edges {
            self.remove(edgeFromVertex: edge.originVertex, toVertex: vertex)
        }
        
        return true
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
    mutating func add(vertices vertices: [Vertex], withEdges edges: [GraphEdge<Vertex>]) -> Bool {
        self.add(vertices: vertices)
        return self.add(edges: edges)
    }
    
    /**
     
     Returns an arbitrary, but not necessarily random, vertex from the graph.
     
     - returns:
     Arbitrary vertex in the graph.
     */
    func anyVertex() -> Vertex? {
        return adjacencyList.keys.first
    }
    
    /**
     
     All vertices in the graph.
     
     - returns:
     All vertices.
     */
    func vertices() -> [Vertex] {
        return Array(adjacencyList.keys)
    }
    
    /**
     
     All vertices adjacent (in the neighborhood) of the given vertex.
     
     - returns:
     All vertices one edge away from the given vertex.
     
     - parameters:
        - vertex: Origin vertex
     */
    func vertices(adjacentTo vertex: Vertex) -> [Vertex]? {
        
        guard let edges = self.adjacencyList[vertex] else {
            return nil
        }
        
        return edges.reduce([Vertex](), combine: { $0 + [$1.0]})
    }
    
    /**
     
     All edges in the graph.
     
     - returns:
     All edges.
     */
    func edges() -> [GraphEdge<Vertex>] {
        
        var allEdges = [GraphEdge<Vertex>]()
        for (vertex, _) in self.adjacencyList {
            allEdges += self.edges(fromVertex: vertex)!
        }
        
        if self.directed {
            return allEdges
        }
        
        // Remove all duplicate edges if the graph is undirected
        allEdges = allEdges.map { (edge: GraphEdge<Vertex>) -> GraphEdge<Vertex> in
            var edge = edge
            if edge.originVertex.hashValue < edge.targetVertex.hashValue {
                swap(&edge.originVertex, &edge.targetVertex)
            }
            return edge
        }
        return Array(Set(allEdges))
    }
    
    /**
     
     All edges originating from a vertex. Edges are defined as tuples (a,b,w) 
     such that a is the origin, b is the endpoint, and w is the weight.
     
     - returns:
     All edges from a vertex.
     
     - parameters:
        - vertices: Vertex for the edges to originate from.
     */
    func edges(fromVertex vertex: Vertex) -> [GraphEdge<Vertex>]? {
        
        guard let startVertexEdges = self.adjacencyList[vertex] else {
            return nil
        }
        
        let edges: [GraphEdge<Vertex>] = startVertexEdges.reduce([], combine: {
            $0 + [GraphEdge(origin: vertex, target: $1.0, weight: $1.1)]
        })
        return edges

    }
    
    /**
     
     All edges pointing to a vertex. Edges are defined as tuples (a,b,w) such 
     that a is the origin, b is the endpoint, and w is the weight.
     
     - returns:
     All edges pointing to the vertex.
     
     - parameters:
        - vertices: Vertex for the edges to point to.
     */
    func edges(toVertex vertex: Vertex) -> [GraphEdge<Vertex>]? {
        
        guard let _ = self.adjacencyList[vertex] else {
            return nil
        }
        
        var allEdges = [GraphEdge<Vertex>]()
        for (originVertex, edges) in self.adjacencyList {
            for (targetVertex, weight) in edges {
                if targetVertex == vertex {
                    allEdges.append(GraphEdge(origin: originVertex, target: vertex, weight: weight))
                }
            }
        }
        return allEdges
        
    }
    
}