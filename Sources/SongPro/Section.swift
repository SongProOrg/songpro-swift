//
//  Section.swift
//  SongPro Editor
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import Foundation

public class Section: Codable, Equatable {
    public var name: String?
    public var lines = [Line]()

    public static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.name == rhs.name &&
            lhs.lines == rhs.lines
    }
}
