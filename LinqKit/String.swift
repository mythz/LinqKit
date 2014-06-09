//
//  String.swift
//  SwiftLinq
//
//  Created by Demis Bellot on 6/8/14.
//  Copyright (c) 2014 ServiceStack LLC. All rights reserved.
//

import Foundation

extension String {
    var length: Int { return countElements(self) }
    
    func contains(s:String) -> Bool {
        return (self as NSString).containsString(s)
    }
    
    func charAt(index:Int) -> String {
        let c = (self as NSString).characterAtIndex(index)
        let s = NSString(format:"%c",c)
        return s
    }
    
    func trim() -> String {
        return (self as String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}
