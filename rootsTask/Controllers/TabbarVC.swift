//
//  TabbarVC.swift
//  rootsTask
//
//  Created by Hatem on 21/04/2025.
//

import UIKit

class TabbarVC: UITabBarController {

    //MARK: - Properties
    private let headerView = MainHeaderView()
    private let headerHeight: CGFloat = 60

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupTabBarAppearance()
        setupTabs()

    }


}

//MARK: - Configurations
extension TabbarVC {
   
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor =
            .white.withAlphaComponent(0.85)
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance

        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .black.withAlphaComponent(0.8)
    }

    private func setupTabs() {
        let tab1 = HomeVC()
        tab1.tabBarItem = UITabBarItem(
            title: "Home".localized,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))

        let tab2 = MapVC()
        tab2.tabBarItem = UITabBarItem(
            title: "Map".localized,
            image: UIImage(systemName: "map"),
            selectedImage: UIImage(systemName: "map.fill"))

        let tab3 = MovieVC()
        tab3.tabBarItem = UITabBarItem(
            title: "Data".localized,
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet"))

        viewControllers = [tab1, tab2, tab3].map {
            UINavigationController(rootViewController: $0)
        }
    }
    private func setupHeader() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerHeight),
        ])
        headerView.optionButton.menu = makeOptionsMenu()
        headerView.optionButton.showsMenuAsPrimaryAction = true
    }

    private func makeOptionsMenu() -> UIMenu {
        let langAction = UIAction(
            title: "Change Language".localized, image: UIImage(systemName: "globe")
        ) { [weak self] _ in
            guard let self = self else { return }

            self.changeLangDirect()
        }

        let logoutAction = UIAction(
            title: "Logout".localized, image: UIImage(systemName: "power")
        ) { _ in
            self.navigateWithXibAsRoot(to: LoginVC.self)
            UserDefaults.standard.set(false, forKey: "isLoggined")

        }

        return UIMenu(title: "Setting".localized, children: [langAction, logoutAction])
    }
}

extension TabbarVC {
    func changeLangDirect(){
        let newLang = Language.currentLanguage().contains(Language.Languages.ar) ? Language.Languages.en : Language.Languages.ar
        Language.setAppLanguage(lang: newLang)

        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        let window = sceneDelegate?.window
        let tabbarVC = TabbarVC(nibName: "TabbarVC", bundle: nil)
        window?.rootViewController = tabbarVC
        window?.makeKeyAndVisible()
    }
    @objc
    func changeLanguage() {
        let current =
            UserDefaults.standard.string(forKey: "appLanguage") ?? "en"
        let next = (current == "en") ? "ar" : "en"
        UserDefaults.standard.set(next, forKey: "appLanguage")
        openAppSettings {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                exit(0)
            }
        }
    }
    
    func openAppSettings(completion: @escaping () -> Void) {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsURL, options: [:]) { _ in
                    completion()
                }
            } else {
                UIApplication.shared.openURL(settingsURL)
                completion()
            }
        }
    }
}

