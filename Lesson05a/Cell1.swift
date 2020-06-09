//
//  Cell1.swift
//  Lesson05a
//
//  Created by Hajin Jeong on 2020/06/08.
//  Copyright © 2020 AmazingHajin. All rights reserved.
//

import UIKit

class Cell1: UITableViewCell {

    
    @IBOutlet weak var img01: UIImageView!
    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var label03: UILabel!
    @IBOutlet weak var label04: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
