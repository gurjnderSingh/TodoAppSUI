//
//  ListViewModel.swift
//  TodoListSUI
//
//  Created by Gurjinder Singh on 02/11/23.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    let itemKey: String = "item_List"
    
    init() {
        getItems()
    }
    func addItem(title: String) {
        let newItem = ItemModel(Title: title, IsCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = self.items.firstIndex(where: { $0.id == item.id }) {
            self.items[index] = item.updateCompleted()
        }
    }
    
    func deleteItem(indexSet: IndexSet) { // new
        self.items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        self.items.move(fromOffsets: from, toOffset: to)
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemKey)
        }
    }
    
    func getItems() {
        guard let data = UserDefaults.standard.data(forKey: itemKey) else { return }// check data
        guard let savedItem = try? JSONDecoder().decode([ItemModel].self, from: data) else { return }
        self.items = savedItem
    }
}

