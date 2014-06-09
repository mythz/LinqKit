//
//  ArrayTests.swift
//  LinqKit
//
//  Created by Demis Bellot on 6/9/14.
//  Copyright (c) 2014 ServiceStack LLC. All rights reserved.
//

class ArrayTests: TestsBase {

    func testEach() {
        var times = 0
        [1,2,3].each { n in times++; return }
        times == 3
    }
    
    func testFind() {
        let numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]
        let lowNums = numbers.find { $0 < 5}
        
        XCTAssert(lowNums == [4,1,3,2,0])
    }
    
    func testFindIndex() {
        let digits = ["one", "four", "five", "seven", "two", "three", "six"]
        let shortDigits = digits.find { $0.length < $1 }
        
        XCTAssert(shortDigits == ["two", "six"])
    }
    
    func testAny(){
        var words = [ "believe", "relief", "receipt", "field" ]
        var iAfterE = words.any { $0.contains("ei") }
        
        XCTAssert(isAfterE)
        
        words = [ "believe", "relief", "field" ]
        iAfterE = words.any { $0.contains("ei") }
        
        XCTAssert(!iAfterE)
    }
    
    func testAll(){
        var words = [ "believe", "relief", "field" ]
        var eAfterI = words.all { $0.contains("ie") }
        
        XCTAssert(eAfterI)
        
        words = [ "believe", "relief", "receipt", "field" ]
        eAfterI = words.any { $0.contains("ie") }
        
        XCTAssert(!eAfterI)
    }
    
    func testExpand(){
        let numbersA = [ 1, 2, 3, 4, 5 ]
        let numbersB = [ 1, 2, 3 ]
        
        let ab = numbersA.expand { a in
            numbersB
                .find { b in a < b }
                .map { b in a + b }
        }
        
        XCTAssert(ab == [3,4,5])
    }
    
    func testTake(){
        let numbers = [ 1, 2, 3, 4, 5 ]
        let first3 = numbers.take(3)
        
        XCTAssert(first3 == [1,2,3])
    }
    
    func testSkip(){
        let numbers = [ 1, 2, 3, 4, 5 ]
        let skip3 = numbers.skip(3)
        
        XCTAssert(skip3 == [4,5])
    }
    
    func testTakeWhile(){
        let numbers = [ 1, 2, 3, 4, 5 ]
        let under4 = numbers.takeWhile { $0 <= 3 }
        
        XCTAssert(skip3 == [1,2,3])
    }
    
    func testSkipWhile(){
        let numbers = [ 1, 2, 3, 4, 5 ]
        let over4 = numbers.skipWhile { $0 <= 3 }
        
        XCTAssert(over4 == [4,5])
    }
    
    func testFirstWhere(){
        var numbers = [ 1, 2, 3, 4, 5 ]
        var over4 = numbers.firstWhere { $0 > 3 }
        
        XCTAssert(over4! == 4)

        numbers = [ 1, 2, 3 ]
        over4 = numbers.firstWhere { $0 > 3 }
        
        XCTAssert(over4 == nil)
    }
    
    func testFirstWhereOrElse(){
        let numbers = [ 1, 2, 3 ]
        let over4 = numbers.firstWhere( { $0 > 3 }, orElse: { -1 })
        
        XCTAssert(over4 == -1)
    }
    
    func testSortBy(){
        let words = [ "aPPLE", "AbAcUs", "bRaNcH", "BlUeBeRrY", "ClOvEr", "cHeRry" ]
        
        let sortedWords = words.sortBy(
            { $0.length == $1.length ? 0 : $0.length > $1.length ? 1 : -1 },
            { $0.uppercaseString.compare($1.uppercaseString) }
        )
        
        sortedWords == [ "BlUeBeRrY", "ClOvEr", "cHeRry", "bRaNcH", "AbAcUs",  "aPPLE"]
    }
    
    func testIndexOf(){
        let words = [ "aPPLE", "AbAcUs", "bRaNcH", "BlUeBeRrY", "ClOvEr", "cHeRry" ]
        
        let indexOf = words.indexOf("bRaNcH")
        
        XCTAssert(indexOf == 2)
    }
    
    func testContains(){
        let words = [ "aPPLE", "AbAcUs", "bRaNcH", "BlUeBeRrY", "ClOvEr", "cHeRry" ]
        
        let contains = words.contains("bRaNcH")
        XCTAssert(contains)
    }
    
    func testToDictionary(){
        let digits = ["two", "three", "four"]
        
        let map = digits.toDictionary { (s:String) in s.length }
        
        XCTAssert(map[3] == "two" && map[5] == "three")
    }
}
