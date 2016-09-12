//
//  DijkstrasAlgorithm.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/11/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

extension AdjacencyListGraph {
    
    /// Dijkstra's Shortest Path Algorithm
    func shortestPath(fromVertex vertex: Vertex, toVertex goalVertex:Vertex) -> [GraphEdge<Vertex>]? {
        typealias GraphEdgePath = (weight: Int, path: [GraphEdge<Vertex>])
        
        // Ensure they're not the same vertex
        if vertex == goalVertex {
            return []
        }
        
        // If the vertex does not exist, this is impossible
        guard let edgesFromStart = self.edges(fromVertex: vertex) else {
            return nil
        }
        
        // Keep all the paths in a min heap, sorted by edge weight
        var edgePathsMinHeap: Heap<GraphEdgePath> = Heap {
            (edgePathA: GraphEdgePath, edgePathB: GraphEdgePath) -> Bool in
            return edgePathA.weight < edgePathB.weight
        }
        
        // Add all of the edges as the beginning paths
        edgePathsMinHeap.insert(edgesFromStart.map({ (edge: GraphEdge<Vertex>) -> GraphEdgePath in
            return (weight: edge.weight, path: [edge])
        }))
        
        // Keep track of the shortest path to each vertex
        var shortestPathToVertex: [Vertex : Int] = self.vertices().reduce([Vertex : Int]()) {
            (dict: [Vertex : Int], v: Vertex) -> [Vertex : Int] in
            var retDir = dict
            retDir[v] = Int.max
            return retDir
        }
        shortestPathToVertex[vertex] = 0
        
        // While there exists another path to check
        while let shortestEdgePath = edgePathsMinHeap.pop() {
            
            // Get the last vertex in the path
            let lastEdge = shortestEdgePath.path.last!
            let lastVertex = lastEdge.targetVertex
            
            // If we found the goal vertex, return this path
            if lastVertex == goalVertex {
                return shortestEdgePath.path
            }
            
            // Update the shortest path
            shortestPathToVertex[lastVertex] = shortestEdgePath.weight
            
            // Make sure there are edges off the graph
            guard var edgesFromVertex = self.edges(fromVertex: lastVertex) else {
                continue
            }
            
            // Filter out edges to vertices we've already checked
            edgesFromVertex = edgesFromVertex.filter({ shortestPathToVertex[$0.targetVertex] == Int.max })
            
            // Add the new edges to the shortest path and re insert in the heap
            edgePathsMinHeap.insert(edgesFromVertex.map({ (edge: GraphEdge<Vertex>) -> GraphEdgePath in
                return (weight: edge.weight + shortestEdgePath.weight, path: shortestEdgePath.path + [edge])
            }))
            
        }
        
        return nil
    }
}
