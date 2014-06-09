//
//  Slice.swift
//  SwiftLinq
//
//  Created by Demis Bellot on 6/9/14.
//  Copyright (c) 2014 ServiceStack LLC. All rights reserved.
//

import Foundation

extension Slice {
    func each(fn: (T) -> ()) {
        for i in self {
            fn(i)
        }
    }
}