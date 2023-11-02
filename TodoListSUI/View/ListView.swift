//
//  ListView.swift
//  TodoListSUI
//
//  Created by Gurjinder Singh on 02/11/23.
//

import SwiftUI

struct ListView: View {

    @EnvironmentObject var listViewModel: ListViewModel // accessing already created object not creating new one

    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoListView()
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            } else {
                List {
                    // dont need Id bcoz of Identifiable
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(Animation.easeInOut(duration: 0.2),{
                                    listViewModel.updateItem(item: item)
                                })
                            }
                    }
                    .onDelete { indexSet in
                        listViewModel.deleteItem(indexSet: indexSet)
                    }
                    .onMove { indexSet, index in
                        listViewModel.moveItem(from: indexSet, to: index)
                    }
                }
                
            }
        }
        .navigationTitle("Todo List ✍️")
        .navigationBarItems(leading: EditButton(), trailing: NavigationLink(destination: {
            AddView()
        }, label: {
            Text("Add")
        }))
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel()) // causing crash so add here for preview
    }
}
