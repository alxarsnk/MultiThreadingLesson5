//
//  CustomTableViewCell.swift
//  testPara
//
//  Created by Александр Арсенюк on 01.10.2018.
//  Copyright © 2018 Александр Арсенюк. All rights reserved.
//

import UIKit

protocol CustomCellDelegate: class {
    func didPressInfoButton()
}
class CustomTableViewCell: UITableViewCell {
    weak var delegate: CustomCellDelegate?
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var postNameLabel: UILabel!
    
    @IBAction func shareButton(_ sender: Any) {
        delegate?.didPressInfoButton()
    }
    func configureCell (with image: UIImage, nameString: String, delegate: CustomCellDelegate) {
        imagePost.image = image
        postNameLabel.text = nameString
        self.delegate = delegate
    
    }
  
}
