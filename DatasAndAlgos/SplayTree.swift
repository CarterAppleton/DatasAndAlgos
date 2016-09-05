//
//  SplayTree.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

class SplayTree<E: Comparable>  {
    
    private var item: E!
    private var leftNode: SplayTree?
    private var rightNode: SplayTree?
    
    init(item: E) {
        self.item = item
    }
    
    init(items: [E]) {
        
    }
    
    func insert(item: E) -> SplayTree {
        
        func insert(x: SplayTree, p: SplayTree?, g: SplayTree?, gg: SplayTree?) -> (SplayTree, SplayTree?) {
            
            if let p = p {
                if x.item > p.item {
                    let (tree, spl) = insert(x, p: p.rightNode, g: p, gg: g)
                    if spl == nil {
                        p.rightNode = tree
                        return (splay(p.rightNode!, p: p, g: g),g)
                    } else {
                        return (tree, p === spl ? nil : spl)
                    }
                } else {
                    let (tree, spl) = insert(x, p: p.leftNode, g: p, gg: g)
                    if spl == nil {
                        p.leftNode = tree
                        return (splay(p.leftNode!, p: p, g: g),g)
                    } else {
                        return (tree, p === spl ? nil : spl)
                    }
                }
            }
            
            return (x, nil)
        }
        
        let x = SplayTree(item: item)
        //return insert(x, p: self, g: nil, gg: nil).0
        let (tree, _) = insert(x, p: self, g: nil, gg: nil)
        return tree
    }
    
    func splay(x: SplayTree, p: SplayTree, g: SplayTree?) -> SplayTree {
        
        if let g = g {
            
            // Zig zig on the left
            if p === g.leftNode && x === p.leftNode {
                
                g.leftNode = p.rightNode
                p.rightNode = g
                p.leftNode = x.rightNode
                x.rightNode = p
                
            }
            
            // Zig zig on the right
            else if p === g.rightNode && x === p.rightNode {
                
                g.rightNode = p.leftNode
                p.leftNode = g
                p.rightNode = x.leftNode
                x.leftNode = p
                
            }
            
            // Zig zag right left
            else if p === g.leftNode && x === p.rightNode {
                
                g.leftNode = x.rightNode
                x.rightNode = g
                p.rightNode = x.leftNode
                x.leftNode = p
                
            }
            
            // Zig zag left right
            else if p === g.rightNode && x === p.leftNode {
            
                g.rightNode = x.leftNode
                x.leftNode = g
                p.leftNode = x.rightNode
                x.rightNode = p
                
            }
        }
        
        // Zig step, p is the root
        else {
            
            if x === p.leftNode {

                p.leftNode = x.rightNode
                x.rightNode = p
                
            } else {
                
                p.rightNode = x.leftNode
                x.leftNode = p

            }
            
        }
        
        return x
    }
    
    func treeOrder(tree: SplayTree?) -> String {
        if let tree = tree {
            return "\([tree.item]): {\(treeOrder(tree.leftNode)), \(treeOrder(tree.rightNode))}"
        }
        return ""
    }
    
    private func inOrder(tree: SplayTree?) -> [E] {
        if let tree = tree {
            return inOrder(tree.leftNode) + [tree.item] + inOrder(tree.rightNode)
        }
        return []
    }
}

extension SplayTree : SequenceType {
    typealias Generator = AnyGenerator<E>

    
    func generate() -> Generator {
        var index = 0
        var arr = self.inOrder(self)
        return AnyGenerator {
            if index < arr.count {
                let v = index
                index += 1
                return arr[v]
            }
            return nil
        }
    }
}
