//
//  ContentView.swift
//  notes
//
//  Created by Chetan Sidhu on 7/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var noteData = NoteData()
    
    var body: some View {

        
        NavigationView {
            VStack {
                if noteData.note1.isEmpty {
                    Text("Add a note!")
                } else {
                    HomeView()
                }
            }
            .navigationTitle(("Notes"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        noteData.addNote(title: "Edit Me!", info: "", favorite: false)
                    } label: {
                        Label("Image", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        noteData.resetUserDate()
                    } label: {
                        Label("Image", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
            .environmentObject(noteData)
        
    }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

