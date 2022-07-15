//
//  HomeView.swift
//  notes
//
//  Created by Chetan Sidhu on 7/12/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var noteData: NoteData
    var body: some View {
        List {
            ForEach(noteData.note1) { note in
                NavigationLink(destination: NoteInfoView(note: note).environmentObject(noteData)) {
                    HStack {
                        Text(note.title)
                        Spacer()
                        Image(systemName: "star")
                            .symbolVariant(note.favorite ? .fill : .none)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(NoteData())
    }
}
