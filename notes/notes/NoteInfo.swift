//
//  NoteInfo.swift
//  notes
//
//  Created by Chetan Sidhu on 7/12/22.
//

import Foundation
import SwiftUI

struct Note1 : Codable, Hashable, Identifiable {
    var id = UUID()
    var title: String
    var info: String
    var favorite: Bool
}

@MainActor class NoteData : ObservableObject {
    private let NOTES_KEY = "noteKey"
    var note1: [Note1] {
        didSet {
            objectWillChange.send()
            saveData()
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: NOTES_KEY) {
            if let decodedNotes = try? JSONDecoder().decode([Note1].self, from: data) {
                note1 = decodedNotes
                return
            }
        }
        note1 = []
    }
    
    func addNote(title: String, info: String, favorite: Bool) {
        let tempNote = Note1(title: title, info: info, favorite: false)
        note1.insert(tempNote, at: 0)
        saveData()
    }
    
    func editNote(id: UUID, title: String, info: String, favorite: Bool) {
        if let editNote = note1.first(where: { $0.id == id }) {
            let index = note1.firstIndex(of: editNote)
            note1[index!].title = title
            note1[index!].info = info
            note1[index!].favorite = favorite
        }
    }
    
    
    private func saveData() {
        if let encodedNotes = try? JSONEncoder().encode(note1) {
            UserDefaults.standard.set(encodedNotes, forKey: NOTES_KEY)
        }
    }
    
    func resetUserDate() {
        for note in note1 {
            if (note.favorite) {
                print("favorite")
                
            }
            else if (note.favorite == false) {
                print("not favorite")
                if let editNote = note1.first(where: { $0.id == note.id }) {
                    let index = note1.firstIndex(of: editNote)
                    UserDefaults.standard.removeObject(forKey: NOTES_KEY)
                    UserDefaults.resetStandardUserDefaults()
                    note1.remove(at: index!)
                
            }
            
        }

    }
    }
    func deleteNote(id: UUID, title: String, info: String, favorite: Bool) {
        if let editNote = note1.first(where: { $0.id == id }) {
            let index = note1.firstIndex(of: editNote)
            note1.remove(at: index!)
        }
    }
    
    func randomPassword() {
        
        var password = ""
        for _ in 1...16 {
            let addition = generateNumber()
            password += String(addition)
        }
        UIPasteboard.general.string = password
    }
    
    func generateNumber() -> Character {
        // initialize variables
        let randomLetter = "abcdefghijklmnopqrstuvwxyz"
        let randomSpecial = "!?#"
        var letter: Character = "1"
        // special characters
        
        let r = Int.random(in: 1...3)
        if (r == 1) {
            letter = randomLetter.randomElement()!
            let l = Int.random(in: 1...2)
            if (l == 2) {
                letter = Character(letter.uppercased())
            }
        }
        else if (r == 2) {
            let num = Int.random(in: 1...9)
            letter = Character(String(num))
        }
        else if (r == 3) {
            letter = randomSpecial.randomElement()!
        }
        
        return letter
    }
}
