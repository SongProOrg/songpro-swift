//
//  Line.swift
//  SongPro Editor
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import Foundation

public class Line: Codable, Equatable {
    public var parts = [Part]()
    public var measures = [Measure]()
    public var tablature: String?
    public var comment: String?
    
    public static func == (lhs: Line, rhs: Line) -> Bool {
        return lhs.parts == rhs.parts &&
            lhs.measures == rhs.measures &&
            lhs.tablature == rhs.tablature &&
            lhs.comment == rhs.comment
    }
}
