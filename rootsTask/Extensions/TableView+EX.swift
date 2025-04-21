//
//  TableView+EX.swift
//  rootsTask
//
//  Created by Hatem on 21/04/2025.
//

import UIKit

extension UITableView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0.1, animations: { self.reloadData()})
        {_ in completion() }
    }
    
    func registerTVCell<Cell:UITableViewCell>(cellClass: Cell.Type){
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeue<Cell: UITableViewCell>(inx:IndexPath) -> Cell{
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: inx) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
    
}
