//
//  TodoListSUIApp.swift
//  TodoListSUI
//
//  Created by Gurjinder Singh on 02/11/23.
//

import SwiftUI

@main
struct TodoListSUIApp: App {
    
    @StateObject var listViewModel = ListViewModel() // should be on root
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
