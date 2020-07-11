//
//  Measure.swift
//  
//
//  Created by Brian Kelly on 7/1/20.
//

import Foundation

public class Measure: Codable, Equatable {
    public var chords = [String]()
    
    public static func == (lhs: Measure, rhs: Measure) -> Bool {
        return lhs.chords == rhs.chords
    }
}
