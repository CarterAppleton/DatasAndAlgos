//
//  Trie.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/8/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

struct Trie {
    
    /// Whether or not this Trie is the endpoint for a word
    private var isWord = false
    
    /// All the words that branch off from this Trie
    private var words = [Character : Trie]()
    
    /**
     
     Initialize an empty Trie.
     
     - returns:
     An empty Trie.
     */
    init() { }
    
    /**
     
     Initialize a Trie with a word.
     
     - returns:
     A Trie with the given word.
     
     - parameters:
        - word: String to add to the Trie.
     */
    init(withWord word: String) {
        self.add(word)
    }
    
    /**
     
     Initialize a Trie with multiple words
     
     - returns:
     A Trie with the given words.
     
     - parameters:
        - words: Sequence of Strings.
     */
    init<S : SequenceType where S.Generator.Element == String>(_ words: S) {
        self.add(words)
    }
    
    /**
     
     Add a given word.
     
     - parameters:
        - word: String to add.
     */
    mutating func add(word: String) {
        
        if let firstCharacter = word.characters.first {
            // Grab the first character of the word if it exists
            // Try to add to the next Trie, otherwise set a new next Trie
            let subString = word.substringFromIndex(word.startIndex.successor())
            if self.words[firstCharacter]?.add(subString) == nil {
                self.words[firstCharacter] = Trie(withWord: subString)
            }
            
        } else {
            // If there is no first character, this is the end of the word
            self.isWord = true
        }
    }
    
    /**
     
     Add multiple words.
     
     - parameters:
        - words: Strings to add.
     */
    mutating func add<S : SequenceType where S.Generator.Element == String>(words: S) {
        for word in words {
            self.add(word)
        }
    }
    
    /**
     
     Check if the Trie contains the word.
     
     - parameters:
        - words: String to check existence of.
     */
    func contains(word: String) -> Bool {
        
        // If we have the first character, ask the next Trie if it contains
        //  the rest of the String. Otherwise return false.
        if let firstCharacter = word.characters.first {
            let subString = word.substringFromIndex(word.startIndex.successor())
            if let nextTrie = self.words[firstCharacter] {
                return nextTrie.contains(subString)
            } else {
                return false
            }
        } else {
            // If we're at the end of the string, return if the Trie is a word
            return self.isWord
        }
    }
    
    /**
     
     Return all of the words in the Trie.
     
     - returns:
        - All of the words in the Trie.
     */
    func allWords() -> [String] {
        
        /// Helper function that takes a trie and current word and returns
        ///  all of the Strings that make up words in that Trie.
        func allWords(trie: Trie, currentWord: String) -> [String] {
            
            var words = [String]()
            
            if trie.isWord {
                words.append(currentWord)
            }
            
            for (character, trie) in trie.words {
                words += allWords(trie, currentWord: currentWord + "\(character)")
            }
            
            return words
        }
        
        return allWords(self, currentWord: "")
    }
}