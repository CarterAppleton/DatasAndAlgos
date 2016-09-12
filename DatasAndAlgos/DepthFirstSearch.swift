//
//  DepthFirstSearch.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/8/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

extension AdjacencyListGraph {
    
    /// Depth first search
    func depthFirstSearch(item: Vertex) -> Bool {
        
        func depthFirstSearch(vertex: Vertex, item: Vertex, inout seenVertices: Set<Vertex>) -> Bool {
            
            // If we found the item, return
            if vertex == item {
                return true
            }
            
            // If we're in a cycle, return
            if seenVertices.contains(vertex) {
                return false
            }
            
            seenVertices.insert(vertex)
            
            // For each neighbor, depth first search
            if let nextVertices = self.vertices(adjacentTo: vertex) {
                for v in nextVertices {
                    if depthFirstSearch(v, item: item, seenVertices: &seenVertices) {
                        return true
                    }
                }
            }
            
            return false
        }
        
        // Keep track of vertices we haven't seen
        var unseenVertices: Set<Vertex> = Set(self.vertices())
        
        // While there are vertices we haven't seen, run depth first search
        //  on the next. For connected graphs, this will only run once.
        while let vertex = unseenVertices.first {

            var seenVertices = Set<Vertex>()
            
            // Run depth first search starting from this vertex
            if depthFirstSearch(vertex, item: item, seenVertices: &seenVertices) {
                return true
            }
            
            // Remove all seen vertices from our unseen ones
            for vert in seenVertices {
                unseenVertices.remove(vert)
            }
        }
        
        return false
    }
    
    /// Depth first search
    func cycleExists() throws -> Bool {
        
        // Graph must be undirected
        if self.directed {
            throw GraphStructureError.NotUndirected
        }
        
        func depthFirstSearch(vertex: Vertex, previousVertex: Vertex?, inout seenVertices: Set<Vertex>) -> Bool {
            
            // If we're in a cycle, return
            if seenVertices.contains(vertex) {
                return true
            }
            
            seenVertices.insert(vertex)
            
            // For each neighbor, depth first search
            if let nextVertices = self.vertices(adjacentTo: vertex) {
                for v in nextVertices {
                    if v == previousVertex {
                        continue
                    }
                    if depthFirstSearch(v, previousVertex: vertex, seenVertices: &seenVertices) {
                        return true
                    }
                }
            }
            
            return false
        }
        
        // Keep track of vertices we haven't seen
        var unseenVertices: Set<Vertex> = Set(self.vertices())
        
        // While there are vertices we haven't seen, run depth first search
        //  on the next. For connected graphs, this will only run once.
        while let vertex = unseenVertices.first {
            
            var seenVertices = Set<Vertex>()
            
            // Run depth first search starting from this vertex
            if depthFirstSearch(vertex, previousVertex: nil, seenVertices: &seenVertices) {
                return true
            }
            
            // Remove all seen vertices from our unseen ones
            for vert in seenVertices {
                unseenVertices.remove(vert)
            }
        }
        
        return false
    }
    
    
}