//
//  ListTableViewCell.swift
//  presentation
//
//  Created by 中井日向子 on 2022/06/12.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
   
    @IBOutlet var titlelabel: UILabel!
    @IBOutlet var targettimelabel: UILabel!
    @IBOutlet var timerlabel: UILabel!
    @IBOutlet var manuscriptlabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
