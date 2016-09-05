//
//  SplayTree.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/4/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

class SplayTree<E: Comparable>  {
    
    /// The value at this node, nil if this is the head.
    private var item: E?
    
    /// Left subtree, beginning of the tree if this is the head.
    private var leftNode: SplayTree?
    
    /// Right subtree, always nil if this is the head
    private var rightNode: SplayTree?
    
    /**
     
     Initialize an empty SplayTree.
     
     - returns:
     An empty SplayTree.
    */
    init() {
        
    }

    /**
     
     Initialize a SplayTree with the given item.
     
     - returns:
     A SplayTree with the given item.
     
     - parameters:
        - item: Item to build the SplayTree from
     */
    init(_ item: E) {
        self.insert(item)
    }
    
    /**
     
     Initialize a SplayTree with the given items.
     
     - returns:
     A SplayTree with the given items.
     
     - parameters:
        - item: Items to build the SplayTree from
     */
    init<S : SequenceType where S.Generator.Element == E>(_ items: S) {
        self.insert(items)
    }
    
    /**
     
     Insert a given item into the SplayTree.
     
     - parameters:
        - item: Item to add to the SplayTree
     */
    func insert(item: E) {
        
        func insert(x: SplayTree, p: SplayTree?, g: SplayTree?, gg: SplayTree?) -> (SplayTree, SplayTree?) {
            
            // 1. Insert recursively until p is nil (and so x is added)
            // 2. If spl == nil: splay - we must be the parent of x or the great
            //                    grandparent of a previous splay. Return the
            //                    new tree and the next node to splay at.
            //    otherwise    : don't splay - we are in a previous splay. If
            //                    the parent is the next splay target, flag this
            //                    by returning (tree,nil). Otherwise (tree,spl).
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
            
            // No parent, so x is the only tree
            return (x, nil)
        }
        
        // Construct x so it doesn't call insert (so it doesn't act like a head)
        let x = SplayTree()
        x.item = item
        
        let (tree, _) = insert(x, p: self.leftNode, g: nil, gg: nil)
        
        // We are head node, so use leftNode to point to our SplayTree
        self.leftNode = tree
    }
    
    /**
     
     Insert items into the SplayTree.
     
     - parameters:
        - items: Items to add to the SplayTree
     */
    func insert<S : SequenceType where S.Generator.Element == E>(items: S) {
        for item in items {
            self.insert(item)
        }
    }
    
    /**
     
     Splay the target item (x) to the root.
     
     - returns:
     A new SplayTree with x at the root.
     
     - parameters:
        - x: Target node of the splay operation
        - p: Parent of the target
        - g: Grandparent of the target, if it exists
     */
    private func splay(x: SplayTree, p: SplayTree, g: SplayTree?) -> SplayTree {
        
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
            
            // Zig left
            if x === p.leftNode {

                p.leftNode = x.rightNode
                x.rightNode = p
                
            // Zig right
            } else {
                
                p.rightNode = x.leftNode
                x.leftNode = p

            }
            
        }
        
        return x
    }
    
    /**
     
     Pre-order pretty string representation of the SplayTree.
     
     - returns:
     String representation of the SplayTree
     
     */
    func treeOrder() -> String {
        
        func treeOrder(tree: SplayTree?) -> String {
            if let tree = tree {
                return "\([tree.item]): {\(treeOrder(tree.leftNode)), \(treeOrder(tree.rightNode))}"
            }
            return ""
        }
        
        return treeOrder(self.leftNode)
    }
    
    /**
     
     Returns an array of the in-order traversal of the SplayTree.
     
     - returns:
     Array of the in-order traversal of the SplayTree.
     */
    func inOrder() -> [E] {
        return self.inOrder(true)
    }
    
    /**
     
     Returns an array of the in-order traversal of the SplayTree. This is
     reversed if orderIncreasing is false.
     
     - returns:
     Array of the in-order traversal of the SplayTree.
     
     - parameters:
        - orderIncreasing: If true, traverses min to max; reverse otherwise.
     */
    func inOrder(orderIncreasing: Bool) -> [E] {
        
        func inOrder(tree: SplayTree?) -> [E] {
            if let tree = tree {
                var left = inOrder(tree.leftNode)
                var right = inOrder(tree.rightNode)
                if !orderIncreasing {
                    swap(&left, &right)
                }
                return left + [tree.item!] + right
            }
            return []
        }
        
        return inOrder(self.leftNode)
    }
}

/**
 
 Extend SplayTree so it can be:
 * Iterated through in a For-in loop
 * Used to initialize any object taking SequenceType
 
 */
extension SplayTree : SequenceType {
    typealias Generator = AnyGenerator<E>

    func generate() -> Generator {
        var index = 0
        var arr = self.inOrder(true)
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
