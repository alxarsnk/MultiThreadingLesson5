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

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {

    var dataArray: [Post] = []
    @IBOutlet weak var tableView: UITableView!

    
    @IBAction func addButtonPressed(_ sender: Any) {
        dataArray.append(Post(imagePost: dataManager.ObtainRandomPhoto(), textPost: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."))
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.top)
        tableView.endUpdates()
    }
    
    var dataManager: DataStorage = DataStorage()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        tableView.estimatedRowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        /*dataManager.asyncObtainData { [unowned self](postArray) in
            self.dataArray = postArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }*/
       self.dataArray = dataManager.syncObtainData()//синхронная подгрузка данных
        print(dataArray.count)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let posts = dataArray[indexPath.row]
        
        cell.configureCell(with: dataManager.ObtainRandomPhoto(), nameString: dataManager.ObtainRandomName(), delegate: self)
        
        
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue", let model = sender as? Post {
            
            let destinationController = segue.destination as! ViewController
            destinationController.model = model
        }
    }
    func didPressInfoButton() {
        
        let model = Post(imagePost: dataManager.ObtainRandomPhoto() , textPost: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.")
        
        performSegue(withIdentifier: "detailSegue", sender: model)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            dataArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }

  }
    extension Int {
        func printMySelf() {
            print("Int number: \(self)")
        }
    }


