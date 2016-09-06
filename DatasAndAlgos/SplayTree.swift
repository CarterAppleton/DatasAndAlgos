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
     
     - returns:
     True if the insertion was successful. False if item already exists.
     
     - parameters:
        - item: Item to add to the SplayTree
     */
    func insert(item: E) -> Bool {
        
        func insert(tree: SplayTree, intoTree mainTree: SplayTree?) -> Bool {
            if let mainTree = mainTree {
                if tree.item > mainTree.item {
                    if let right = mainTree.rightNode {
                        return insert(tree, intoTree: right)
                    }
                    mainTree.rightNode = tree
                    return true
                } else if tree.item < mainTree.item {
                    if let left = mainTree.leftNode {
                        return insert(tree, intoTree: left)
                    }
                    mainTree.leftNode = tree
                    return true
                }
            }
            return false
        }
        
        // Construct x so it doesn't call insert (so it doesn't act like a head)
        let x: SplayTree<E> = SplayTree()
        x.item = item
        
        // If there are no nodes in the tree, add one
        if self.leftNode == nil {
            self.leftNode = x
            return true
        }
        
        // On successful insert, splay inserted node to the root
        if insert(x, intoTree: self.leftNode) {
            let tree = self.splay(item, tree: self.leftNode)
            if let tree = tree {
                // We are head node, so use leftNode to point to our SplayTree
                self.leftNode = tree
                return true
            }
        }
        
        // Node already exists in tree
        return false
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
     
     Removes and returns the item from the tree, or nil if the item doesn't exist.
     
     - parameters:
        - item: Item to remove from the SplayTree
     */
    
    func join(leftTree: SplayTree?, rightTree: SplayTree?) -> SplayTree? {
        
        if let leftMaxNode = self.maxNode(leftTree) {
            
            // Splay the value in the left tree to the root
            let tree = self.splay(leftMaxNode.item!, tree: leftTree)
            
            // Right node must be nil as the root is maximal, so this is safe
            tree!.rightNode = rightTree
            
            return tree
        }
        
        return rightTree
    }
    
    /**
     
     Remove a given item from the SplayTree.
     
     - returns:
     The item if removal was successful. Nil if item doesn't exist.
     
     - parameters:
        - item: Item to remove from the SplayTree
     */
    func remove(item: E) -> E? {
        
        // Splay the node equal to x to the root
        let tree = self.splay(item, tree: self.leftNode)
        
        // Splay only fails if tree doesn't exist. Join the right and left trees
        if let tree = tree {
            self.leftNode = self.join(tree.leftNode, rightTree: tree.rightNode)
            return tree.item!
        }
        
        return nil
    }
    
    /**
     
     Remove given items from the SplayTree.
     
     - parameters:
        - item: Items to remove from the SplayTree
     */
    func remove<S : SequenceType where S.Generator.Element == E>(items: S) {
        for item in items {
            self.remove(item)
        }
    }
    
    /// Recursive helper for maxItem()
    /// Returns max item in the tree or nil if tree is empty
    private func maxNode(tree: SplayTree?) -> SplayTree? {
        if let tree = tree {
            if let element = maxNode(tree.rightNode) {
                return element
            }
            return tree
        }
        
        return nil
    }
    
    /**
     
     Returns the maximum item in the tree, if it exists.
     
     - returns:
     Max item E in the tree or nil if the tree is empty.
     */
    func maxItem() -> E? {
        if let node = self.maxNode(self.leftNode) {
            return node.item
        }
        return nil
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
    
    /**
     
     Recursively splay the node with the target item to the root.
     
     - returns:
     A tree with the node holding the item splayed to the root, or nil if such a node could not be found.
     
     - parameters:
     - item: Item (or equivalent item) of the node to splay to the root
     - tree: Tree to search in and splay
     */
    private func splay(item: E, tree: SplayTree?) -> SplayTree? {
        
        func splayRecursive(x: E, p: SplayTree?, g: SplayTree?, gg: SplayTree?) -> (SplayTree?, SplayTree?) {
            
            // 1. Splay recursively until p is nil (and so x is added)
            // 2. If spl == nil: splay - we must be the parent of x or the great
            //                    grandparent of a previous splay. Return the
            //                    new tree and the next node to splay at.
            //    otherwise    : don't splay - we are in a previous splay. If
            //                    the parent is the next splay target, flag this
            //                    by returning (tree,nil). Otherwise (tree,spl).
            if let p = p {
                if x > p.item {
                    let (tree, spl) = splayRecursive(x, p: p.rightNode, g: p, gg: g)
                    if tree == nil {
                        return (nil, nil)
                    } else if spl == nil {
                        p.rightNode = tree
                        return (splayTrees(p.rightNode!, p: p, g: g),g)
                    } else {
                        return (tree, p === spl ? nil : spl)
                    }
                } else if x < p.item {
                    let (tree, spl) = splayRecursive(x, p: p.leftNode, g: p, gg: g)
                    if tree == nil {
                        return (nil, nil)
                    } else if spl == nil {
                        p.leftNode = tree
                        return (splayTrees(p.leftNode!, p: p, g: g),g)
                    } else {
                        return (tree, p === spl ? nil : spl)
                    }
                } else {
                    return (p, nil)
                }
            }
            return (nil, nil)
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
        func splayTrees(x: SplayTree, p: SplayTree, g: SplayTree?) -> SplayTree {
            
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
        
        let (tree, _) = splayRecursive(item, p: tree, g: nil, gg: nil)
        return tree
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
