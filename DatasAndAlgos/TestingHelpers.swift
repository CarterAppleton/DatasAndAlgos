//
//  TestingHelpers.swift
//  DatasAndAlgos
//
//  Created by Carter Appleton on 9/11/16.
//  Copyright © 2016 Carter Appleton. All rights reserved.
//

func testFunction<E: Equatable>(testCase: String, inputs: [([E]?,[E]?)]) {
    print("Starting Testing: \(testCase)")
    var failedCases = ""
    for (index,input) in inputs.enumerate() {
        if let lhs = input.0, let rhs = input.1 {
            if lhs != rhs {
                failedCases += "\(index), "
            }
        } else if input.0 != nil || input.1 != nil {
            failedCases += "\(index), "
        }
        
    }
    if failedCases != "" {
        print("- FAILED: [\(failedCases.substringToIndex(failedCases.endIndex.predecessor().predecessor()))]")
    } else {
        print("- SUCCESS")
    }
    
    print("")
}

func testFunction<E: Equatable>(testCase: String, inputs: [(E?,E?)]) {
    print("Starting Testing: \(testCase)")
    var failedCases = ""
    for (index,input) in inputs.enumerate() {
        if let lhs = input.0, let rhs = input.1 {
            if lhs != rhs {
                failedCases += "\(index), "
            }
        } else if input.0 != nil || input.1 != nil {
            failedCases += "\(index), "
        }
        
    }
    if failedCases != "" {
        print("- FAILED: [\(failedCases.substringToIndex(failedCases.endIndex.predecessor().predecessor()))]")
    } else {
        print("- SUCCESS")
    }
    
    print("")
}

func testFunction(testCase: String, inputs: [(Bool,Bool)]) {
    print("Starting Testing: \(testCase)")
    var failedCases = ""
    for (index,input) in inputs.enumerate() {
        if input.0 != input.1 {
            failedCases += "\(index), "
        }
    }
    if failedCases != "" {
        print("- FAILED: [\(failedCases.substringToIndex(failedCases.endIndex.predecessor().predecessor()))]")
    } else {
        print("- SUCCESS")
    }
    
    print("")
}