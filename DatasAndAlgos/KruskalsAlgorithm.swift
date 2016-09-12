//
//  PrimsAlgorithm.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/6/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

enum GraphStructureError: ErrorType {
    case NotUndirected
}

extension AdjacencyListGraph {
    
    /// Kruskal's Mininum Spanning Tree Algorithm
    func minimumSpanningTree() throws -> AdjacencyListGraph {

        // Graph must be undirected
        if self.directed {
            throw GraphStructureError.NotUndirected
        }
        
        // Graph to represent the final spanning tree
        var resultGraph = AdjacencyListGraph()
        
        // Keep all the edges in a min heap, sorted by edge weight
        var edgeQueue: Heap<GraphEdge<Vertex>> = Heap(comparison: <, withItems: self.edges())
        
        // Vertices not yet in our result graph
        var unaddedVertices = Set<Vertex>(self.vertices())
        
        // While there are unchecked edges and vertices to be added, try to add
        //  the edges.
        while let edge = edgeQueue.pop() {
            
            resultGraph.add(vertex: edge.originVertex)
            resultGraph.add(vertex: edge.targetVertex)
            resultGraph.add(edgeFromVertex: edge.originVertex, toVertex: edge.targetVertex, withWeight: edge.weight)
            
            if try resultGraph.cycleExists() {
                resultGraph.remove(edgeFromVertex: edge.originVertex, toVertex: edge.targetVertex)
            } else {
                unaddedVertices.remove(edge.originVertex)
                unaddedVertices.remove(edge.targetVertex)
            }

        }
        
        // Add all of the unadded vertices. Only vertices with no edges connected
        //  to them will be added here.
        resultGraph.add(vertices: Array(unaddedVertices))
        
        return resultGraph
    }
}

