//
//  BookstoreStategistApp.swift
//  BookstoreStategist
//
//

import SwiftUI

@main
struct BookstoreStategistApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            ContentView()
            #else
            MacContentView()
            #endif
        }
    }
}
