//
//  LaunchVC.swift
//  rootsTask
//
//  Created by Hatem on 20/04/2025.
//
import UIKit

class LaunchVC: BaseVC {

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoggined()
    }
}

//MARK: - Configurations
extension LaunchVC {
    func isLoggined (){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.isLoggined {
                self.navigateWithXibAsRoot(to: TabbarVC.self)
            } else {
                self.navigateWithXibAsRoot(to: LoginVC.self)
            }
        }
    }
}
