//
//  CollectionView+EX.swift
//  rootsTask
//
//  Created by Hatem on 21/04/2025.
//
import UIKit

extension UICollectionView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0.1, animations: { self.reloadData()})
        {_ in completion() }
    }
    
    
    func centerSelectedCell(indexPath:IndexPath,animated:Bool=true){
        self.scrollToItem(at: indexPath, at:.centeredHorizontally, animated: animated)
    }
    
    
    func registerCell<Cell: UICollectionViewCell>(cell: Cell.Type){
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    
    func dequeue<Cell: UICollectionViewCell>(inx:IndexPath) -> Cell{
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: inx) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
    
}
