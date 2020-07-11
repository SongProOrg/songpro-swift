//
//  Song.swift
//  SongPro Editor
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import Foundation

public class Song: Codable, Equatable {
    public var title: String?
    public var artist: String?
    public var capo: String?
    public var key: String?
    public var tempo: String?
    public var year: String?
    public var album: String?
    public var tuning: String?
    public var custom = [String: String]()
    public var sections = [Section]()
    
    public static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.title == rhs.title &&
            lhs.artist == rhs.artist &&
            lhs.capo == rhs.capo &&
            lhs.key == rhs.key &&
            lhs.tempo == rhs.tempo &&
            lhs.year == rhs.year &&
            lhs.album == rhs.album &&
            lhs.tuning == rhs.tuning &&
            lhs.custom == rhs.custom &&
            lhs.sections == rhs.sections
    }
}
