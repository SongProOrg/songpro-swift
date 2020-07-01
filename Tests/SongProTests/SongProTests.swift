import XCTest
@testable import SongPro

final class SongProTests: XCTestCase {
    func testItParsesAttributes() {
        let song = SongPro.parse("""
@title=Bad Moon Rising
@artist=Creedence Clearwater Revival
@capo=1st Fret
@key=C# Minor
@tempo=120
@year=1975
@album=Foo Bar Baz
@tuning=Eb Standard
""")
        
        XCTAssertEqual(song.title, "Bad Moon Rising")
        XCTAssertEqual(song.artist, "Creedence Clearwater Revival")
        XCTAssertEqual(song.capo, "1st Fret")
        XCTAssertEqual(song.key, "C# Minor")
        XCTAssertEqual(song.tempo, "120")
        XCTAssertEqual(song.year, "1975")
        XCTAssertEqual(song.album, "Foo Bar Baz")
        XCTAssertEqual(song.tuning, "Eb Standard")
    }

    func testItParsesCustomAttributes() {
        let song = SongPro.parse("""
!difficulty=Easy
!spotify_url=https://open.spotify.com/track/5zADxJhJEzuOstzcUtXlXv?si=SN6U1oveQ7KNfhtD2NHf9A
""")
        
        XCTAssertEqual(song.custom["difficulty"], "Easy")
        XCTAssertEqual(song.custom["spotify_url"], "https://open.spotify.com/track/5zADxJhJEzuOstzcUtXlXv?si=SN6U1oveQ7KNfhtD2NHf9A")
    }
    
    func testItParsesMultipleSectionNames() {
        let song = SongPro.parse("""
# Verse 1
# Chorus
""")
        
        XCTAssertEqual(song.sections.count, 2)
        XCTAssertEqual(song.sections[0].name, "Verse 1")
        XCTAssertEqual(song.sections[1].name, "Chorus")
    }

    func testItParsesLyrics() {
        let song = SongPro.parse("I don't see! a bad, moon a-rising. (a-rising)")
        
        XCTAssertEqual(song.sections.count, 1)
        XCTAssertEqual(song.sections[0].lines.count, 1)
        XCTAssertEqual(song.sections[0].lines[0].parts.count, 1)
        XCTAssertEqual(song.sections[0].lines[0].parts[0].lyric, "I don't see! a bad, moon a-rising. (a-rising)")
    }
    
    func testItParsesLyricsWithSpecialCharacters() {
        let song = SongPro.parse("singing sömething with Röck dots")

        XCTAssertEqual(song.sections.count, 1)
        XCTAssertEqual(song.sections[0].lines.count, 1)
        XCTAssertEqual(song.sections[0].lines[0].parts.count, 1)
        XCTAssertEqual(song.sections[0].lines[0].parts[0].lyric, "singing sömething with Röck dots")
    }
    
    func testItParsesChords() {
        let song = SongPro.parse("[D] [D/F#] [C] [A7]")

        XCTAssertEqual(song.sections.count, 1)
        XCTAssertEqual(song.sections[0].lines.count, 1)
        XCTAssertEqual(song.sections[0].lines[0].parts.count, 4)
        XCTAssertEqual(song.sections[0].lines[0].parts[0].chord, "D")
        XCTAssertEqual(song.sections[0].lines[0].parts[0].lyric, " ")
        XCTAssertEqual(song.sections[0].lines[0].parts[1].chord, "D/F#")
        XCTAssertEqual(song.sections[0].lines[0].parts[1].lyric, " ")
        XCTAssertEqual(song.sections[0].lines[0].parts[2].chord, "C")
        XCTAssertEqual(song.sections[0].lines[0].parts[2].lyric, " ")
        XCTAssertEqual(song.sections[0].lines[0].parts[3].chord, "A7")
        XCTAssertEqual(song.sections[0].lines[0].parts[3].lyric, "")
    }
    
    func testItParsesChordsAndLyrics() {
        let song = SongPro.parse("[G]Don't go 'round tonight")
      
        XCTAssertEqual(song.sections.count, 1)
        XCTAssertEqual(song.sections[0].lines.count, 1)
        XCTAssertEqual(song.sections[0].lines[0].parts.count, 1)
        XCTAssertEqual(song.sections[0].lines[0].parts[0].chord, "G")
        XCTAssertEqual(song.sections[0].lines[0].parts[0].lyric, "Don't go 'round tonight")
    }

    func testItParsesLyricsBeforeChords() {
        let song = SongPro.parse("It's [D]bound to take your life")

        XCTAssertEqual(song.sections.count, 1)
        XCTAssertEqual(song.sections[0].lines.count, 1)
        XCTAssertEqual(song.sections[0].lines[0].parts.count, 2)
        XCTAssertEqual(song.sections[0].lines[0].parts[0].chord, "")
        XCTAssertEqual(song.sections[0].lines[0].parts[0].lyric, "It's ")
        XCTAssertEqual(song.sections[0].lines[0].parts[1].chord, "D")
        XCTAssertEqual(song.sections[0].lines[0].parts[1].lyric, "bound to take your life")
    }

    func testItParsesLyricsInbetweenChords() {
        let song = SongPro.parse("It's a[D]bout a [E]boy")
      
        XCTAssertEqual(song.sections.count, 1)
        XCTAssertEqual(song.sections[0].lines.count, 1)
        XCTAssertEqual(song.sections[0].lines[0].parts.count, 3)
        XCTAssertEqual(song.sections[0].lines[0].parts[0].chord, "")
        XCTAssertEqual(song.sections[0].lines[0].parts[0].lyric, "It's a")
        XCTAssertEqual(song.sections[0].lines[0].parts[1].chord, "D")
        XCTAssertEqual(song.sections[0].lines[0].parts[1].lyric, "bout a ")
        XCTAssertEqual(song.sections[0].lines[0].parts[2].chord, "E")
        XCTAssertEqual(song.sections[0].lines[0].parts[2].lyric, "boy")
    }
    
    func testItParsesChordOnlyMeasures() {
        let song = SongPro.parse("""
# Instrumental
| [A] [B] | [C] | [D] [E] [F] [G] |
""")
        XCTAssertEqual(song.sections.count, 1)
        XCTAssertEqual(song.sections[0].lines[0].measures.isEmpty, false)
        XCTAssertEqual(song.sections[0].lines[0].measures.count, 3)
        XCTAssertEqual(song.sections[0].lines[0].measures[0].chords, ["A", "B"])
        XCTAssertEqual(song.sections[0].lines[0].measures[1].chords, ["C"])
        XCTAssertEqual(song.sections[0].lines[0].measures[2].chords, ["D", "E", "F", "G"])
    }
}
