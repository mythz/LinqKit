//
//  Double.swift
//  SwiftLinq
//
//  Created by Demis Bellot on 6/9/14.
//  Copyright (c) 2014 ServiceStack LLC. All rights reserved.
//

import Foundation

extension Double : Reducable {
    static func max() -> Double {
        return Double(Int.max)
    }
}

func /(lhs: Double, rhs: Int) -> Double {
    return lhs / Double(rhs)
}