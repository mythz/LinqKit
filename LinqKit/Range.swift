//
//  Range.swift
//  SwiftLinq
//
//  Created by Demis Bellot on 6/9/14.
//  Copyright (c) 2014 ServiceStack LLC. All rights reserved.
//

import Foundation

extension Range {
    
    func map<T,U>(fn: (T) -> U) -> U[] {
        var to = U[]()
        for i in self {
            to += fn(i as T)
        }
        return to
    }
}