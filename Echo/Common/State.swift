//
//  State.swift
//  Echo
//
//  Created by ShengHua Wu on 02/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation

enum State<T> {
    case normal(T)
}

extension State where T: RangeReplaceableCollection {
    var count: T.IndexDistance {
        switch self {
        case let .normal(elements): return elements.count
        }
    }
    
    func element(at index: T.Index) -> T.Iterator.Element {
        switch self {
        case let .normal(elements): return elements[index]
        }
    }
    
    func append(_ element: T.Iterator.Element) -> State {
        switch self {
        case let .normal(elements):
            return .normal(elements + [element])
        }
    }
}
