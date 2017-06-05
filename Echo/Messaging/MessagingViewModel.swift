//
//  MessagingViewModel.swift
//  Echo
//
//  Created by ShengHua Wu on 02/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation

final class MessagingViewModel {
    // MARK: Properties
    private(set) var state: State<[Message]> = .normal([]) {
        didSet {
            callback(state)
        }
    }
    
    private let callback: (State<[Message]>) -> ()
    
    // MARK: Designated Initializer
    init(callback: @escaping (State<[Message]>) -> ()) {
        self.callback = callback
    }
    
    // MARK: Public Methods
    func appendMessage(with text: String) {
        let newMessage = Message(text: text, isSentByMe: true)
        state = state.append(newMessage)
    }
}
