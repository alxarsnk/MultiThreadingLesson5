//
//  File.swift
//  testPara
//
//  Created by Александр Арсенюк on 22.10.2018.
//  Copyright © 2018 Александр Арсенюк. All rights reserved.
//

import Foundation
import UIKit

public extension ExpressibleByIntegerLiteral {
    public static func arc4random() -> Self {
        var r: Self = 0
        arc4random_buf(&r, MemoryLayout<Self>.size)
        return r
    }
}
var photoArray: [UIImage] = [#imageLiteral(resourceName: "post3"), #imageLiteral(resourceName: "post2"), #imageLiteral(resourceName: "postimg"), #imageLiteral(resourceName: "danis")]
var nameArray: [String] = ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", "Test", "        "]


/// Полуение рандомного числа
///
/// - Returns: рандомное число
func rnd() -> Int {
    let phrnd = arc4random_uniform(UInt32(photoArray.count))
    return Int(phrnd)
}

protocol Data{
    func asyncObtainData(completion: @escaping ([Post])-> Void)
    func syncObtainData()->[Post]
    func asyncSaveData(completion: @escaping ([Post]) -> [Post])
    func ObtainRandomName() -> String
    func ObtainRandomPhoto() -> UIImage
    
    
}
class DataStorage:Data{
    
    
   
    let nmrnd = arc4random_uniform(UInt32(nameArray.count))
    
    let sum = rnd()
    
    /// Асинхронное получение данных
    ///
    /// - Parameter completion: Захват Массива Постов
    func asyncObtainData(completion: @escaping ([Post])-> Void) {
        DispatchQueue.global()
        
        let dataArray = [Post](repeating: Post(imagePost: photoArray[Int(rnd())] , textPost: nameArray[Int(nmrnd)]), count: 20)
        completion(dataArray)
    }
    /// Синхронное получение данных
    ///
    /// - Returns: возвращает массив постов
    func syncObtainData() -> [Post] {
        let dataArray = [Post](repeating: Post(imagePost: photoArray[rnd()] , textPost: nameArray[Int(nmrnd)]), count: 20)
        return dataArray
    }
    func asyncSaveData(completion: @escaping ([Post]) -> [Post]) {
         DispatchQueue.global()
    }
     func ObtainRandomName() -> String {
        return nameArray[Int(nmrnd)]
    }
    func ObtainRandomPhoto() -> UIImage {
        
        return photoArray[rnd()]
    }
    
    
    
}
