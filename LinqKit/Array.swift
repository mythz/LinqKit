//
//  Array.swift
//  SwiftLinq
//
//  Created by Demis Bellot on 6/8/14.
//  Copyright (c) 2014 ServiceStack LLC. All rights reserved.
//

import Foundation

protocol Addable {
    func +(lhs: Self, rhs: Self) -> Self
    init()
}

protocol Reducable : Addable, Averagable, Comparable {
    class func max() -> Self
}

protocol Averagable : Addable {
    func /(lhs: Self, rhs: Int) -> Double
}

extension Array {
    func each(fn: (T) -> ()) {
        for i in self {
            fn(i)
        }
    }
    
    func find(fn: (T) -> Bool) -> T[] {
        var to = T[]()
        for x in self {
            let t = x as T
            if fn(t) {
                to += t
            }
        }
        return to
    }
    
    func find(fn: (T, Int) -> Bool) -> T[] {
        var to = T[]()
        var i = 0
        for x in self {
            let t = x as T
            if fn(t, i++) {
                to += t
            }
        }
        return to
    }
    
    func any(fn: (T) -> Bool) -> Bool {
        return self.find(fn).count > 0
    }
    
    func all(fn: (T) -> Bool) -> Bool {
        return self.find(fn).count == self.count
    }
    
    func expand<TResult>(fn: (T) -> TResult[]?) -> TResult[] {
        var to = TResult[]()
        for x in self {
            if let result = fn(x as T) {
                for r in result {
                    to += r
                }
            }
        }
        return to
    }
    
    func take(count:Int) -> T[] {
        var to = T[]()
        var i = 0
        while i < self.count && i < count {
            to += self[i++]
        }
        return to
    }
    
    func skip(count:Int) -> T[] {
        var to = T[]()
        var i = count
        while i < self.count {
            to += self[i++]
        }
        return to
    }
    
    func takeWhile(fn: (T) -> Bool) -> T[] {
        var to = T[]()
        for x in self {
            let t = x as T
            if fn(t) {
                to += t
            }
            else {
                break
            }
        }
        return to
    }
    
    func skipWhile(fn: (T) -> Bool) -> T[] {
        var to = T[]()
        var keepSkipping = true
        for x in self {
            let t = x as T
            if !fn(t) {
                keepSkipping = false
            }
            if !keepSkipping {
                to += t
            }
        }
        return to
    }
    
    func firstWhere(fn: (T) -> Bool) -> T? {
        for x in self {
            if fn(x) {
                return x
            }
        }
        return nil
    }
    
    func firstWhere(fn: (T) -> Bool, orElse: () -> T) -> T {
        for x in self {
            if fn(x) {
                return x
            }
        }
        return orElse()
    }
    
    func sortBy(fns: ((T,T) -> Int)...) -> T[]
    {
        var items = self.copy()
        items.sort { x, y in
            for f in fns {
                let r = f(x,y)
                if r != 0 {
                    return r > 0
                }
            }
            return false
        }
        return items
    }
    
    func groupBy<Key : Hashable, Item>(fn:(Item) -> Key) -> Group<Key,Item>[] {
        return self.groupBy(fn, nil, nil)
    }
    
    func groupBy<Key : Hashable, Item>(fn:(Item) -> Key, matchWith:((Key,Key) -> Bool)?) -> Group<Key,Item>[] {
        return self.groupBy(fn, matchWith, nil)
    }
    
    func groupBy<Key : Hashable, Item>
        (
        fn:        (Item) -> Key,
        matchWith: ((Key,Key) -> Bool)?,
        valueAs:   (Item -> Item)?
        )
        -> Group<Key,Item>[]
    {
        var ret = Item[]()
        var map = Dictionary<Key, Group<Key,Item>>()
        for x in self {
            var e = x as Item
            let val = fn(e)
            
            var key = val as Key
            
            if matchWith {
                for k in map.keys {
                    if matchWith!(val, k) {
                        key = k
                        break
                    }
                }
            }
            
            if valueAs {
                e = valueAs!(e)
            }
            
            var group = map[key] ? map[key]! : Group<Key,Item>(key:key)
            group.append(e)
            map[key] = group //always copy back struct
        }
        
        return map.values.map { $0 as Group<Key,Item> }
    }
    
    func contains<T : Equatable>(x:T) -> Bool {
        return self.indexOf(x) != nil
    }
    
    func indexOf<T : Equatable>(x:T) -> Int? {
        for i in 0..self.count {
            if self[i] as T == x {
                return i
            }
        }
        return nil
    }
    
    func toDictionary<Key : Hashable, Item>(fn:Item -> Key) -> Dictionary<Key,Item> {
        var to = Dictionary<Key,Item>()
        for x in self {
            let e = x as Item
            let key = fn(e)
            to[key] = e
        }
        return to
    }
    
    func sum<T : Addable>() -> T
    {
        return self.map { $0 as T }.reduce(T()) { $0 + $1 }
    }
    
    func sum<U, T : Addable>(fn: (U) -> T) -> T {
        return self.map { fn($0 as U) }.reduce(T()) { $0 + $1 }
    }
    
    func min<T : Reducable>() -> T {
        return self.map { $0 as T }.reduce(T.max()) { $0 < $1 ? $0 : $1 }
    }
    
    func min<U, T : Reducable>(fn: (U) -> T) -> T {
        return self.map { fn($0 as U) }.reduce(T.max()) { $0 < $1 ? $0 : $1 }
    }
    
    func max<T : Reducable>() -> T {
        return self.map { $0 as T }.reduce(T()) { $0 > $1 ? $0 : $1 }
    }
    
    func max<U, T : Reducable>(fn: (U) -> T) -> T {
        return self.map { fn($0 as U) }.reduce(T()) { $0 > $1 ? $0 : $1 }
    }
    
    func avg<T : Averagable>() -> Double
    {
        return self.map { $0 as T }.reduce(T()) { $0 + $1 } / self.count
    }
    
    func avg<U, T : Averagable>(fn: (U) -> T) -> Double {
        return self.map { fn($0 as U) }.reduce(T()) { $0 + $1 } / self.count
    }
}

func distinct<T : Equatable>(this:T[]) -> T[] {
    return union(this)
}

func union<T : Equatable>(arrays:T[]...) -> T[] {
    return _union(arrays)
}

func _union<T : Equatable>(arrays:T[][]) -> T[] {
    var to = T[]()
    for arr in arrays {
        outer: for x in arr {
            let e = x as T
            for y in to {
                if y == e {
                    continue outer
                }
            }
            to += e
        }
    }
    return to
}

func intersection<T : Equatable>(arrays:T[]...) -> T[] {
    var all: T[] = _union(arrays)
    var to = T[]()
    
    for x in all {
        var count = 0
        let e = x as T
        outer: for arr in arrays {
            for y in arr {
                if y == e {
                    count++
                    continue outer
                }
            }
        }
        if count == arrays.count {
            to += e
        }
    }
    
    return to
}

func difference<T : Equatable>(from:T[], other:T[]...) -> T[] {
    var to = T[]()
    for arr in other {
        for x in from {
            if !arr.contains(x) && !to.contains(x) {
                to += x
            }
        }
    }
    return to
}
