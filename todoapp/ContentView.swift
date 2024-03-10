//
//  ContentView.swift
//  todoapp
//
//  Created by Thomas Cubillos arcos on 10-03-24.
//

import SwiftUI

struct ContentView: View {
    @State var description: String = ""
    @StateObject var notesViewModel = NotesViewModel();
    
    var body: some View {
        VStack {
            Text("Añade una tarea")
                .underline()
                .foregroundColor(.gray)
                .padding(.horizontal,16)
            TextEditor(text: $description)
                .foregroundColor(.gray)
                .frame(height: 100)
                .overlay{
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.purple, lineWidth: 2)
                }
                .padding(.horizontal, 12)
                .cornerRadius(3.0)
            Button("Crear"){
                notesViewModel.saveNote(descriptionAux: description)
                description = ""
            }
            .buttonStyle(.bordered)
            .tint(.purple)
            Spacer()
            
            List{
                ForEach($notesViewModel.notes, id: \.id){
                    $note in
                    HStack{
                        if note.isFavorited{
                            Text("🌟")
                        }
                        Text(note.description)
                    }
                    .swipeActions(edge: .trailing){
                        Button{
                            notesViewModel.updateFavoriteNote(note: $note)
                        }
                    label:{
                        Label("Favorito",systemImage: "star.fill")
                    }
                    .tint(.yellow)
                    }
                    
                    .swipeActions(edge: .leading){
                        Button{
                            notesViewModel.removeNote(withId: note.id)
                        }
                    label:{
                        Label("Borrar",systemImage: "trash.fill")
                    }
                    .tint(.red)
                    }
                }
            }
        }
        .navigationTitle("Todo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
