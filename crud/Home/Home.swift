//
//  Home.swift
//  crud
//
//  Created by Erick Martins on 02/02/22.
//

import SwiftUI
import CoreData

struct Home: View {
    
    @StateObject var homeData = HomeViewModel()
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .spring()) var results: FetchedResults<Task>
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            
            VStack(spacing: 0) {
                
                HStack{
                    
                    Text("Tarefas")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
//                    Spacer()
                    
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                
                if results.isEmpty{
                    
                    Spacer()
                    Text("Não há tarefas!")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    
                    Spacer()
                    
                } else{
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        LazyVStack(alignment: .leading, spacing: 20){
                            
                            ForEach(results){ task in
                                
                                VStack(alignment: .leading, spacing: 5, content: {
                                    
                                    Text(task.content ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                })
                                    .foregroundColor(.black)
                                    .background(Color.blue.opacity(0.4))
                                    .onTapGesture {
                                        homeData.editItem(item: task)
                                    }
                                    .contextMenu {
                                        
                                        Button(action: { homeData.editItem(item: task)}, label: {
                                            Text("Edit")
                                        })
                                        
                                        Button(action: {
                                            homeData.delete(context: context, task: task)
                                        }, label: {
                                            Text("Delete")
                                        })
                                    }
                                
                            }
                        }
                        .padding()
                    })
                }
            }
            
            Button(action: { homeData.isNewData.toggle()}, label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        
                        AngularGradient(gradient: .init(colors: [Color("Color"), Color("Color1")]), center: .center))
                    .clipShape(Circle())
            })
                .padding()
        })
            .ignoresSafeArea(.all, edges: .top)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
            .sheet(isPresented: $homeData.isNewData, onDismiss: {
                homeData.content = ""
                homeData.updateItem = nil
            }, content: {
                NewDataView(homeData: homeData)
            })
    }
}
