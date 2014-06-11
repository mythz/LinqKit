LinqKit
=======

LINQ-like extensions for Swift

Originally extracted from [101 LINQ Samples in Swift](https://github.com/mythz/swift-linq-examples), LinqKit gives Swift more functional powers making working with models and collections more enjoyable.

```swift
let numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]
let lowNums = numbers.find { $0 < 5 }


let digits = [ "zero", "one", "two", "three", "four", "five", 
               "six", "seven", "eight", "nine" ]
               
let shortDigits = digits.find { digit, index in digit.length < index }


let numbersA = [ 0, 2, 4, 5, 6, 8, 9 ]
let numbersB = [ 1, 3, 5, 7, 8 ]

let pairs = numbersA.expand { a in
    numbersB
        .find { b in a < b }
        .map { i -> (a: Int, b:Int) in (a, i) }
    }

let take3 = numbers.take(3)
let skip3 = numbers.skip(3)

let firstNumbersLessThan6 = numbers.takeWhile { $0 < 6 }

var index = 0
let firstSmallNumbers = numbers.takeWhile { $0 >= index++ }

let allButFirst3Numbers = numbers.skipWhile { $0 % 3 != 0 }

let sortedProducts = products.sortBy(
    { compare($0.category, $1.category) },
    { compare($1.unitPrice, $0.unitPrice) }
)

let numberGroups = numbers.groupBy { $0 % 5 }
    .map { g -> (Remainder: Int, Numbers: Group<Int,Int>) in
        (g.key, g)
    }

let anagrams = [ "from   ", " salt", " earn ", "  last   ", " near ", " form  " ]

let orderGroups = anagrams.groupBy({ (s:String) in s.trim() }, anagramComparer)

let orderGroups = anagrams.groupBy({ (s:String) in s.trim() },
    matchWith: anagramComparer,
    valueAs: { s in s.uppercaseString })

let factorsOf300 = [ 2, 2, 3, 5, 5 ]
let uniqueFactors = distinct(factorsOf300)

let numbersA = [ 0, 2, 4, 5, 6, 8, 9 ]
let numbersB = [ 1, 3, 5, 7, 8 ]
let uniqueNumbers = union(numbersA, numbersB)
let commonNumbers = intersection(numbersA, numbersB)
let aOnlyNumbers = difference(numbersA, numbersB)


let scoreRecords = [
    ( Name: "Alice", Score: 50),
    ( Name: "Bob", Score: 40),
    ( Name: "Cathy", Score: 45),
]
let scoreRecordsDict = scoreRecords.toDictionary {
    (x:(Name:String,Score:Int)) in x.Name
}

let strings = [ "zero", "one", "two", "three", "four", "five", 
                "six", "seven", "eight", "nine" ]

let startsWithO = strings.firstWhere { $0.charAt(0) == "o" }

let numbers:Int[] = []
let firstNumOrDefault = numbers.firstWhere({ n in true }, orElse: { 0 })


let words = [ "believe", "relief", "receipt", "field" ]
let iAfterE = words.any { $0.contains("ei") }

let numbers = [ 1, 11, 3, 19, 41, 65, 19 ]
let onlyOdd = numbers.all { $0 % 2 == 1 }


let products = productsList()
let productGroups = products.groupBy { $0.category }
    .find { $0.items.all { p in p.unitsInStock > 0 } }
    .map { g -> (Category:String, Products:Group<String,Product>) in
        (g.key, g)
    }


let numSum:Int = numbers.sum()
let minNum:Int = numbers.min()
let maxNum:Int = numbers.max()

let totalChars = words.sum { (s:String) in s.length }
let shortestWord = words.min { (s:String) in s.length }
let averageNum = numbers.avg { $0 as Int }
```







