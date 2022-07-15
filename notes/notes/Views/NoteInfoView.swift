//
//  NoteInfoView.swift
//  notes
//
//  Created by Chetan Sidhu on 7/12/22.
//

import SwiftUI

struct NoteInfoView: View {
    @EnvironmentObject var noteData : NoteData
    @State var note : Note1
    @Environment(\.presentationMode) var present
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    
                    TextField("Edit me!", text: $note.title)
                        .textSelection(.enabled)
                        .onTapGesture {
                            note.title = ""
                        }
                        
                    TextEditor(text: $note.info)
                        .textSelection(.enabled)
                        .frame(height: 500)
                    HStack {
                        Spacer()
                        Button("Confirm") {
                            noteData.editNote(id: note.id, title: note.title, info: note.info, favorite: note.favorite)
                                
                                
                            present.wrappedValue.dismiss()
                        }
                        Spacer()
                        
                    }
                }

            }
        }
        .navigationViewStyle(.stack)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if (note.favorite) {
                        note.favorite = false
                    } else {
                        note.favorite = true
                    }
                } label: {
                    Image(systemName: "star")
                        .symbolVariant(note.favorite ? .fill : .none)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    noteData.randomPassword()
                } label: {
                    Image(systemName: "doc.on.doc")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    noteData.deleteNote(id: note.id, title: note.title, info: note.info, favorite: note.favorite)
                    present.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "trash")
                        .tint(.red)
                }
            }
        }
    }
}


struct NoteInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NoteInfoView(note: Note1(id: UUID(), title: "test", info: "test", favorite: false))
            .environmentObject(NoteData())
    }
}
