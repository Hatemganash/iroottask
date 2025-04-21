//
//  ImageViewCell.swift
//  rootsTask
//
//  Created by Hatem on 21/04/2025.
//

import UIKit

class ImageViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func setupCell(data : UIImage){
        imageView.image = data
    }
    
}
