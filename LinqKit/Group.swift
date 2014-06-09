//
//  Group.swift
//  SwiftLinq
//
//  Created by Demis Bellot on 6/8/14.
//  Copyright (c) 2014 ServiceStack LLC. All rights reserved.
//

import Foundation

struct Group<Key,Item> : Sequence, Printable {
    let key: Key
    var items = Item[]()
    
    init(key:Key) {
        self.key = key
    }
    
    mutating func append(item: Item) {
        items.append(item)
    }
    
    func generate() -> IndexingGenerator<Item[]> {
        return items.generate()
    }
    
    var description: String {
    var s = ""
        for x in items {
            if s.length > 0 {
                s += ", "
            }
            s += "\(x)"
        }
        return "\(key): [\(s)]\n"
    }
}

func join<T,U>(seq:T[], withSeq:U[], match:(T,U)->Bool) -> (T,U)[] {
    return seq.expand { (x:T) in
        withSeq
            .find { y in match(x,y) }
            .map { y in (x,y) }
    }
}

func joinGroup<T : Hashable,U>(seq:T[], withSeq:U[], match:(T,U)->Bool) -> Group<T,(T,U)>[] {
    return join(seq, withSeq, match).groupBy { x -> T in
        let (t,u) = x
        return t
    }
}
