//
//  HeaderView.swift
//  rootsTask
//
//  Created by Hatem on 21/04/2025.
//

import UIKit

class MainHeaderView: UIView {
  
    @IBOutlet weak var optionButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        let nib = UINib(nibName: String(describing: MainHeaderView.self), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        setupOptionButton()
       
    }
    
    private func setupOptionButton() {
        optionButton.accessibilityLabel = "options"
        optionButton.showsMenuAsPrimaryAction = true
    }
   
}
