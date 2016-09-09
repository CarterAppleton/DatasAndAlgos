//
//  DepthFirstSearch.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/8/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

extension AdjacencyListGraph {
    
    /// Depth first search
    func depthFirstSearch(item: E) -> Bool {
        
        func depthFirstSearch(vertex: E, item: E, inout seenVertices: Set<E>) -> Bool {
            
            seenVertices.insert(vertex)
            
            // If we found the item, return
            if vertex == item {
                return true
            }
            
            // If we're in a cycle, return
            if seenVertices.contains(vertex) {
                return false
            }
            
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
        var unseenVertices: Set<E> = Set(self.vertices())
        
        // While there are vertices we haven't seen, run depth first search
        //  on the next. For connected graphs, this will only run once.
        while let vertex = unseenVertices.first {

            var seenVertices = Set<E>()
            
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
}