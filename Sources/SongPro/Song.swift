//
//  Song.swift
//  SongPro Editor
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import Foundation

public class Song {
    var title: String?
    var artist: String?
    var capo: String?
    var key: String?
    var tempo: String?
    var year: String?
    var album: String?
    var tuning: String?

    var custom = [String: String]()

    var sections = [Section]()
}
