//
//  MovieNameCell.swift
//  rootsTask
//
//  Created by Hatem on 21/04/2025.
//

import UIKit

class MovieNameCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupData(data:MovieModelElement) {
        movieNameLabel.text = data.title
    }
    
}
