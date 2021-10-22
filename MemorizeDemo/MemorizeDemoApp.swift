//
//  MemorizeDemoApp.swift
//  MemorizeDemo
//
//  Created by 曾国锐 on 2021/10/22.
//

import SwiftUI

@main
struct MemorizeDemoApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGameVM()
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
