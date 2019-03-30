//
//  ToDoCell.swift
//  ToobyDoo
//
//  Created by student5 on 3/30/19.
//  Copyright © 2019 Hannah Leland. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ToDoCellDelegate : class {
    func checkmarkTapped(sender: ToDoCell)
} // end ToDoCellDelegate

class ToDoCell : UITableViewCell {
    
    var delegate : ToDoCellDelegate?
    
    // MARK - UI Outlets
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.checkmarkTapped(sender: self)
    } // end completeButtonTapped
} // end ToDoCell
