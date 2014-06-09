//
//  Int.swift
//  SwiftLinq
//
//  Created by Demis Bellot on 6/9/14.
//  Copyright (c) 2014 ServiceStack LLC. All rights reserved.
//

import Foundation

func /(lhs: Int, rhs: Int) -> Double {
    return Double(lhs) / Double(rhs)
}

extension Int : Reducable {
    static func max() -> Int {
        return Int.max
    }
}