//
//  ListTableViewCell.swift
//  presentation
//
//  Created by 中井日向子 on 2022/05/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet var titlelabel: UILabel!
    
    @IBOutlet var targettimelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
