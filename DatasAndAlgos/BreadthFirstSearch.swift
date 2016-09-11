//
//  BreadthFirstSearch.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/10/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

extension AdjacencyListGraph {
    
    /// Breadth First Search
    func breadthFirstSearch(forVertex vertex: Vertex, startingAt startVertex: Vertex) -> [Vertex]? {
        
        // Keep track of what we've seen
        var seenVertices = Set<Vertex>()
        
        // Queue the next vertex paths to look at
        var vertexPaths = Queue([startVertex])
        
        while let nextVertexPath = vertexPaths.dequeue() {
            
            // Check the last vertex in the path
            let lastVertex = nextVertexPath.last!
            
            // If this is the vertex we want, return the path
            if lastVertex == vertex {
                return nextVertexPath
            }
            
            seenVertices.insert(lastVertex)
            
            // Breadth first, so add all unseen of the neighbors of this vertex
            if let neighbors = self.vertices(adjacentTo: lastVertex) {
                for neighbor in neighbors {
                    if !seenVertices.contains(neighbor) {
                        vertexPaths.enqueue(nextVertexPath + [neighbor])
                    }
                }
            }
        }
        return nil
    }
    
}