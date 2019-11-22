//
//  ArrayExtensions.swift
//  U17Comic
//  Array 扩展类
//  Created by nongfadai on 2019/11/22.
//  Copyright © 2019 lizubing. All rights reserved.
//

import Foundation

public func ==<T:Equatable>(lhs:[T]?,rhs:[T]?) -> Bool{
    switch (lhs,rhs) {
    case let(lhs?,rhs?):
        return lhs == rhs
    case(.none,.none):
        return true
    default:
        return false
    }
}

extension Array{
    //是否包含某一类型
    public func containsType<T>(of element: T) ->Bool{
        let elementType = type(of: element)
        return contains{ type(of: $0) == elementType }
    }
    //排序？？
    public func decompose() -> (head: Iterator.Element,tail:SubSequence)?{
        return (count > 0) ? (self[0],self[1..<count]) : nil
    }
    
    //枚举遍历
    public func forEachEnumerated(_ body: @escaping(_ offset:Int, _ element :Element) ->Void){
        enumerated().forEach(body)
    }
    
    //安全的获取对应的get index值
    public func get(at index : Int)->Element?{
        guard index >= 0 && index < count else { return nil}
        return self[index]
    }
    
    //插入Arrays到第一个
    public mutating func insertFirst(_ newElement: Element){
        insert(newElement, at: 0)
    }
    
    //获取array随机值
    public func random() -> Element?{
        guard count > 0  else {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    //翻转获取index值
    public func reverseIndex(_ index: Int) ->Int?{
        guard index >= 0 && index < count else {
            return nil
        }
        return Swift.max(count - 1 - index, 0)
    }
    
    //洗牌
    public mutating func shuffle() {
        guard count > 1 else{ return}
        var j : Int
        for i in 0..<(count - 2){
            j = Int(arc4random_uniform(UInt32(count - i )))
            if i != i + j {self.swapAt(i, i+j)}
        }
    }
    
    public func shuffled() -> Array {
        var result = self
        result.shuffle()
        return result
    }
    
    //获取最大值
    public func takeMax(_ n : Int) -> Array{
        return Array(self[0..<Swift.max(0,Swift.min(n, count))])
    }
    
    public func testAll(_ body : @escaping(Element) -> Bool) -> Bool{
        return !contains{!body($0)}
    }
    
    public func testAll(is condition : Bool) -> Bool{
        return testAll{($0 as? Bool) ?? !condition == condition}
    }
}

extension Array where Element: Equatable {

    /// EZSE: Checks if the main array contains the parameter array
    public func contains(_ array: [Element]) -> Bool {
        return array.testAll { self.firstIndex(of: $0) ?? -1 >= 0 }
    }

    /// EZSE: Checks if self contains a list of items.
    public func contains(_ elements: Element...) -> Bool {
        return elements.testAll { self.firstIndex(of: $0) ?? -1 >= 0 }
    }

    /// EZSE: Returns the indexes of the object
    public func indexes(of element: Element) -> [Int] {
        return enumerated().compactMap { ($0.element == element) ? $0.offset : nil }
    }

    /// EZSE: Returns the last index of the object
    public func lastIndex(of element: Element) -> Int? {
        return indexes(of: element).last
    }

    /// EZSE: Removes the first given object
    public mutating func removeFirst(_ element: Element) {
        guard let index = firstIndex(of: element) else { return }
        self.remove(at: index)
    }

    /// EZSE: Removes all occurrences of the given object(s), at least one entry is needed.
    public mutating func removeAll(_ firstElement: Element?, _ elements: Element...) {
        var removeAllArr = [Element]()
        
        if let firstElementVal = firstElement {
            removeAllArr.append(firstElementVal)
        }
        
        elements.forEach({element in removeAllArr.append(element)})
        
        removeAll(removeAllArr)
    }

    /// EZSE: Removes all occurrences of the given object(s)
    public mutating func removeAll(_ elements: [Element]) {
        // COW ensures no extra copy in case of no removed elements
        self = filter { !elements.contains($0) }
    }

    /// EZSE: Difference of self and the input arrays.
    public func difference(_ values: [Element]...) -> [Element] {
        var result = [Element]()
        elements: for element in self {
            for value in values {
                //  if a value is in both self and one of the values arrays
                //  jump to the next iteration of the outer loop
                if value.contains(element) {
                    continue elements
                }
            }
            //  element it's only in self
            result.append(element)
        }
        return result
    }

    /// EZSE: Intersection of self and the input arrays.
    public func intersection(_ values: [Element]...) -> Array {
        var result = self
        var intersection = Array()

        for (i, value) in values.enumerated() {
            //  the intersection is computed by intersecting a couple per loop:
            //  self n values[0], (self n values[0]) n values[1], ...
            if i > 0 {
                result = intersection
                intersection = Array()
            }

            //  find common elements and save them in first set
            //  to intersect in the next loop
            value.forEach { (item: Element) -> Void in
                if result.contains(item) {
                    intersection.append(item)
                }
            }
        }
        return intersection
    }

    /// EZSE: Union of self and the input arrays.
    public func union(_ values: [Element]...) -> Array {
        var result = self
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value)
                }
            }
        }
        return result
    }

    /// EZSE: Returns an array consisting of the unique elements in the array
    public func unique() -> Array {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
}


