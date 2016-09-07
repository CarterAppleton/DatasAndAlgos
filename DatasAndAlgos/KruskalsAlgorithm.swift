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
    
    /// Kruskal's
    func minimumSpanningTree() throws -> AdjacencyListGraph {

        if !self.undirected {
            throw GraphStructureError.NotUndirected
        }
        
        var resultGraph = AdjacencyListGraph(undirected: true)
        var edgeQueue: Heap<GraphEdge<E>> = Heap(type: .Min)
        edgeQueue.insert(self.edges())
        var unaddedVertices = Set<E>(self.vertices())
        while unaddedVertices.count > 0 {
            if let edge = edgeQueue.pop() {
                if !unaddedVertices.contains(edge.originVertex) || !unaddedVertices.contains(edge.targetVertex) {
                    resultGraph.add(vertex: edge.originVertex)
                    resultGraph.add(vertex: edge.targetVertex)
                    resultGraph.add(edgeFromVertex: edge.originVertex, toVertex: edge.targetVertex, withWeight: edge.weight)
                    unaddedVertices.remove(edge.originVertex)
                    unaddedVertices.remove(edge.targetVertex)
                }
            } else {
                break
            }
        }
        
        resultGraph.add(vertices: Array(unaddedVertices))
        
        return resultGraph
    }
}

