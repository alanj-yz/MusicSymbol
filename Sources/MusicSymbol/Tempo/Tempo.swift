
//  Tempo.swift
//  MusicTheory
//
//  Created by Cem Olcay on 21.06.2018.
//  Copyright © 2018 cemolcay. All rights reserved.
//
//  https://github.com/cemolcay/MusicTheory
//

import Foundation

/// Defines the tempo of the music with beats per second and time signature.
public struct Tempo: Codable, CustomStringConvertible {
    
    /// Time signature of music.
    public var timeSignature: TimeSignature
    
    /// Beats per minutes.
    public var bpm: Double
    
    /// Initilizes tempo with time signature and BPM.
    ///
    /// - Parameters:
    ///   - timeSignature: Time Signature.
    ///   - bpm: Beats per minute.
    public init(timeSignature: TimeSignature = TimeSignature(), bpm: Double = 120.0) {
        self.timeSignature = timeSignature
        self.bpm = bpm
    }
    
    /// Caluclates the duration of a note value in seconds.
    public func duration(of noteValue: NoteTimeValue) -> PhysicalDuration {
        return durationPerBeat * (noteValue / timeSignature.noteTimeValue)
    }
    
    public func duration(of note: Note) -> PhysicalDuration {
        return duration(of: note.timeValue)
    }
    
    /// physical time duration for one beat
    public var durationPerBeat: PhysicalDuration {
        return 60.0 / bpm
    }
    
    /// beats of given notes
    public func beats(of note: Note) -> MusicDuration {
        return note.timeValue / timeSignature.noteTimeValue
    }
    
    /// Calculates the note length in samples. Useful for sequencing notes sample accurate in the DSP.
    ///
    /// - Parameters:
    ///   - noteValue: Rate of the note you want to calculate sample length.
    ///   - sampleRate: Number of samples in a second. Defaults to 44100.
    /// - Returns: Returns the sample length of a note value.
    public func sampleLength(of noteValue: NoteTimeValue, sampleRate: Double = 44100.0) -> Double {
        let secondsPerBeat = 60.0 / bpm
        return secondsPerBeat * sampleRate * ((4 / noteValue.type.rawValue) * noteValue.modifier.rawValue)
    }
    
    /// Calculates the LFO speed of a note vaule in hertz.
    public func hertz(of noteValue: NoteTimeValue) -> Double {
        return 1 / duration(of: noteValue)
    }
    
    /// MARK: CustomStringConvertible
    
    public var description: String {
        return "🎼\(timeSignature) bpm:\(Int(bpm))"
    }
}


