//
//  Table.swift
//  swifty_companion
//
//  Created by Denis DEHTYARENKO on 5/6/19.
//  Copyright © 2019 Denis DEHTYARENKO. All rights reserved.
//

import UIKit

class Table: UITableViewCell {

    @IBOutlet weak var project: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
    var project_stud : (String, String )? {
        didSet {
            if let f = project_stud {
                
                project?.text = String(f.0)
                score?.text = String(f.1)
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
