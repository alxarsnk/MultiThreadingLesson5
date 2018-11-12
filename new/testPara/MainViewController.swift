//
//  MainViewController.swift
//  testPara
//
//  Created by Александр Арсенюк on 01.10.2018.
//  Copyright © 2018 Александр Арсенюк. All rights reserved.
//

import UIKit

struct Post{
    var imagePost: UIImage
    var textPost: String
}

    var dataManager: DataStorage = DataStorage()
    var sum = dataManager.ObtainRandomPhoto()

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {
    
    
    /// реализация pulltoupdate
    lazy var refresher: UIRefreshControl = {
        let refreshConrol = UIRefreshControl()
        refreshConrol.tintColor = .black
        refreshConrol.addTarget(self, action: #selector(requestData), for: .valueChanged)
        
        return refreshConrol
    }()
    var dataArray: [Post] = []
    @IBOutlet weak var tableView: UITableView!

    /// То что просиходит при свайпе вниз(обновление данных)
    @objc func requestData() {
        let count = dataArray.count
        for _ in 0..<dataArray.count
        {
            dataArray.remove(at: 0)
             tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            print(dataArray.count)
        }
        for _ in 0..<count
        {
            dataArray.append(Post(imagePost:dataManager.ObtainRandomPhoto() , textPost: dataManager.ObtainRandomName()))
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.top)
        }
 
        tableView.reloadData()
        self.refresher.endRefreshing()
       
    }
    
    /// Добавить ячейку
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func addButtonPressed(_ sender: Any) {
        dataArray.append(Post(imagePost: dataManager.ObtainRandomPhoto(), textPost: dataManager.ObtainRandomName()))
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.top)
        tableView.endUpdates()
    }
    
    //var dataManager: DataStorage = DataStorage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        tableView.estimatedRowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refresher
        dataManager.asyncObtainData { [unowned self](postArray) in
            self.dataArray = postArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
}
    /// Кол-во ячеек в секции
    ///
    /// - Parameters:
    ///   - tableView: Наша таблица
    ///   - section: Секция
    /// - Returns: Кол-во равное массиву постов
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataArray.count
    }
    
    /// Конфиг ячейки
    ///
    /// - Parameters:
    ///   - tableView: Наша таблица
    ///   - indexPath: Индекс настраевомемой ячейки
    /// - Returns: Ячейку возвращаем отредактируемую

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let posts = dataArray[indexPath.row]
        
        cell.configureCell(with: dataManager.ObtainRandomPhoto(), nameString: dataManager.ObtainRandomName(), delegate: self)
        
        return cell
    }
    /// Связь вьюх
    ///
    /// - Parameters:
    ///   - segue: идентификатор
    ///   - sender: <#sender description#>
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue", let model = sender as? Post {
            
            let destinationController = segue.destination as! ViewController
            destinationController.model = model
        }
    }
    /// Нажатие кнопки, открытие новой вьюхи
    func didPressInfoButton() {
        
        let model = Post(imagePost: dataManager.ObtainRandomPhoto() , textPost: dataManager.ObtainRandomName())
        
        performSegue(withIdentifier: "detailSegue", sender: model)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
     /// Возможность редактирование
     ///
     /// - Parameters:
     ///   - tableView: наша таблица
     ///   - indexPath: Индекс редактируемой ячейки
     /// - Returns: Разрешаем редактирование
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    /// Удаляем ячейку
    ///
    /// - Parameters:
    ///   - tableView: Наша таблица
    ///   - editingStyle: доступ редактирование
    ///   - indexPath: Индекс удаляемой ячейки
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            dataArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    
    }
    /// Возможность двигать ячейки
    ///
    /// - Parameters:
    ///   - tableView: Наша таблица
    ///   - sourceIndexPath: Индекс ячейки откуда двигаем
    ///   - destinationIndexPath: Индекс ячейки куда двигаем
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }

  }



