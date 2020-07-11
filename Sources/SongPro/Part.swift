//
//  Part.swift
//  SongPro Editor
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import Foundation

public class Part: Codable, Equatable {
    public var chord: String?
    public var lyric: String?
    
    public var isEmpty: Bool {
        get {
            return chord == "" && lyric == ""
        }
    }
    
    public static func == (lhs: Part, rhs: Part) -> Bool {
        return lhs.chord == rhs.chord &&
            lhs.lyric == rhs.lyric
    }
}
