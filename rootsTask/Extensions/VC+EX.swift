//
//  VC+EX.swift
//  rootsTask
//
//  Created by Hatem on 20/04/2025.
//

import UIKit

extension UIViewController {
    
    func goNav(_ id:String ,_ story:String = "Main",_ animated:Bool = true){
            let storyboard = UIStoryboard(name: story, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier:id)
            navigationController?.pushViewController(vc,animated: animated)
        }
    
    func addAction(view:UIView,selector:Selector){
           view.addGestureRecognizer(UITapGestureRecognizer(target:self, action:selector))
        }
    
    func navigateWithXib<T: UIViewController>(to viewControllerType: T.Type, animated: Bool = true) {
        let nibName = String(describing: viewControllerType) // اسم الـ XIB
        let destinationVC = viewControllerType.init(nibName: nibName, bundle: nil) // تهيئة الـ ViewController من الـ XIB

        // If we already have a navigation controller, push normally
        if let navigationController = self.navigationController {
            navigationController.pushViewController(destinationVC, animated: animated)
        } else {
            // If there is no navigation controller, embed the destinationVC in one
            let navController = UINavigationController(rootViewController: destinationVC)
            self.present(navController, animated: animated, completion: nil)
        }
    }



    func navigateWithXibAsRoot<T: UIViewController>(to viewControllerType: T.Type) {
        let nibName = String(describing: viewControllerType)
        let destinationVC = viewControllerType.init(nibName: nibName, bundle: nil)
        destinationVC.navigationItem.hidesBackButton = true

        let nav = UINavigationController(rootViewController: destinationVC)
        nav.isNavigationBarHidden = true
        nav.modalPresentationStyle = .fullScreen

        if let window = UIApplication.shared.windows.first {
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
    }
    func showToast(message: String, duration: Double = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message.localized
        toastLabel.textColor = .white
        toastLabel.backgroundColor = .darkGray
        toastLabel.textAlignment = .center
        toastLabel.font = .systemFont(ofSize: 14)
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true

        let maxWidth = self.view.frame.width - 40
        let textSize = toastLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
        toastLabel.frame = CGRect(x: 20,
                                  y: 70	 ,
                                  width: maxWidth,
                                  height: textSize.height + 20)

        self.view.addSubview(toastLabel)

        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
