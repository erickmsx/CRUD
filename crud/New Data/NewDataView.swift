//
//  NewDataView.swift
//  crud
//
//  Created by Erick Martins on 02/02/22.
//

import SwiftUI
import CoreData

struct NewDataView: View {
    
    @ObservedObject var homeData: HomeViewModel
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        VStack{
            HStack{
                
                Text("\(homeData.updateItem == nil ? "Adicione Uma" : "Editar") Tarefa")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            VStack {
                TextEditor(text: $homeData.content)
                    .padding()
            }.background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color.blue)
            )
                .padding()
            
            
            Divider()
                .padding(.horizontal)
            
            HStack{
                Text("Clique Abaixo Para Confirmar")
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            Button(action: {homeData.writeData(context: context)}, label: {
                
                Label(
                    title: { Text(homeData.updateItem == nil ? "Adicionar" : "Editar")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    },
                    icon: { Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                    })
                    .padding(.vertical)
//                    .frame(width: UIScreen.main.bounds.width - 30)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 15)
                    .background(
                        
                        LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color1")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
            })
            .padding()
            .disabled(homeData.content == "" ? true : false)
            .opacity(homeData.content == "" ? 0.5 : 1)
        }
        
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
    }
}

