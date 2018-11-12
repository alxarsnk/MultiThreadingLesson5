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
var nameArray: [String] = ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", "Test", "        ", "1", "2"]
var storage: [Post] = []


/// Полуение рандомного числа не больше чем кол-во элеметов в массиве фото
///
/// - Returns: рандомное число
func phrnd() -> Int {
    let phrnd = arc4random_uniform(UInt32(photoArray.count))
    return Int(phrnd)
}
/// Полуение рандомного числа не больше чем кол-во элеметов в массиве имен
///
/// - Returns: рандомное число
func nmrnd() -> Int {
    let nmrnd = arc4random_uniform(UInt32(nameArray.count))
    return Int(nmrnd)
}


protocol Data{
    func asyncObtainData(completion: @escaping ([Post])-> Void)
    func syncObtainData()->[Post]
    func asyncSaveData(completion: @escaping ([Post]) -> Void)
    func syncSaveData()->Void
    func asyncSearchData(str: String, completion: @escaping ([Post]) -> Void)
    func syncSearchData(str: String)->Void
    func ObtainRandomName() -> String
    func ObtainRandomPhoto() -> UIImage
    func cleanStorage () -> Void
    
    
}

class DataStorage:Data {
    
    
    var dataArray: [Post] = []
    
    /// Асинхронное получение данных
    ///
    /// - Parameter completion: Захват Массива Постов
    func asyncObtainData(completion: @escaping ([Post]) -> Void) {
        
        let operation = OperationQueue.init()
        operation.addOperation { [weak self] in
            
            guard self != nil else { return }
            
            let dataArray = [Post](repeating: Post(imagePost: self!.ObtainRandomPhoto(), textPost: self!.ObtainRandomName()), count: 20)
            storage = dataArray
            
            completion(dataArray)
        }
    }
    /// Синхронное получение данных
    ///
    /// - Returns: возвращает массив постов
    func syncObtainData() -> [Post] {
        
        let dataArray = [Post](repeating: Post(imagePost: self.ObtainRandomPhoto() , textPost: self.ObtainRandomName()), count: 20)
        return dataArray
    }
    ///   Асинхронное сохранение данных
    ///
    /// - Parameter completion: <#completion description#>
    func asyncSaveData(completion: @escaping ([Post]) ->Void) {
        
            let operation = OperationQueue.init()
            operation.addOperation { [weak self] in
                guard self != nil else { return }
                completion(storage)
                print(storage)
                
        }
    }
    /// синхронное сохранение и получение данных
    func syncSaveData() {
        dataArray = storage
        print(dataArray)
    }
    ///  Асинхронный поиск
    ///
    /// - Parameters:
    ///   - str: текст по которому ищуь
    ///   - completion: <#completion description#>
    func asyncSearchData(str: String,completion: @escaping ([Post]) -> Void) {
        
        let operation = OperationQueue.init()
        operation.addOperation { [weak self] in
            guard self != nil else { return }
            for model in storage {
                if model.textPost == str {
                    print(model.textPost)
                }   else {
                    print("Ne ta!")
                }
            }
        }
    }
    
    /// Синхронный посик данных
    ///
    /// - Parameter str: текст по которому ищуь
    func syncSearchData(str: String) {
        for model in storage {
            if model.textPost == str {
                print(model.textPost)
            }
        }
    }
    func ObtainRandomName() -> String {
        return nameArray[nmrnd()]
    }
    func ObtainRandomPhoto() -> UIImage {
        
        return photoArray[phrnd()]
    }
    
    
    /// метод очистки хранилища, в которое идет сохранение данных
    func cleanStorage() {
        storage = []
    }
}
