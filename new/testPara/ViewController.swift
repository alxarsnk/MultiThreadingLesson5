//
//  ViewController.swift
//  testPara
//
//  Created by Александр Арсенюк on 01.10.2018.
//  Copyright © 2018 Александр Арсенюк. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var newlabel: UILabel!
    @IBOutlet weak var newimg: UIImageView!
    var model: Post!
    override func viewDidLoad() {
        super.viewDidLoad()
        newimg.image = model.imagePost
        newlabel.text = model.textPost
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

