//
//  Comparers.swift
//  SwiftLinq
//
//  Created by Demis Bellot on 6/9/14.
//  Copyright (c) 2014 ServiceStack LLC. All rights reserved.
//

import Foundation

func compare<T : Comparable>(a:T, b:T) -> Int {
    return a == b
        ? 0
        : a > b ? -1 : 1
}

func anagramComparer(a:String, b:String) -> Bool {
    let aChars = Array(a.nulTerminatedUTF8)
    let bChars = Array(b.nulTerminatedUTF8)
    sort(aChars)
    sort(bChars)
    return aChars == bChars
}

func caseInsensitiveComparer (a:String,b:String) -> Bool {
    return a.uppercaseString.compare(b.uppercaseString) < 0
}

func compareIgnoreCase (a:String,b:String) -> Int {
    return a.uppercaseString.compare(b.uppercaseString)
}