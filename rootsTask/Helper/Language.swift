//
//  Language.swift
//  Base hatem
//
//  Created by Hatem on 01/01/2023.
//


import Foundation
import UIKit

struct Language {
  
  enum Languages {
    static let en = "en"
    static let ar = "ar"
  }
  
  static func currentLanguage() -> String {
    let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
    let firstLanguage = languages.firstObject as! String
    return firstLanguage
  }
  static func setAppLanguage(lang: String) {
    UserDefaults.standard.set([lang], forKey: "AppleLanguages")
    UserDefaults.standard.synchronize()
      
      Bundle.setLanguage(lang)

    self.updateUIDirection()
  }
    
  
  static func apiLanguage() -> String {
    return self.currentLanguage().contains(Languages.ar) ? Languages.ar : Languages.en
  }
  static func isRTL() -> Bool {
    return self.currentLanguage().contains(Languages.ar) ? true : false
  }
  
  static func updateUIDirection(){
    UITabBar.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UIButton.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UIPageControl.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UIStackView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UISwitch.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UIView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .unspecified
    UICollectionView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UICollectionViewCell.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UITableView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UITableViewCell.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UILabel.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UIImageView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UISegmentedControl.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UIDatePicker.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UIPickerView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    UITextField.appearance().textAlignment = Language.isRTL() ? .right : .left
    UITextView.appearance().textAlignment = Language.isRTL() ? .right : .left
  }
}


private var bundleKey: UInt8 = 0

extension Bundle {
    static let once: Void = {
        object_setClass(Bundle.main, LanguageBundle.self)
    }()
    
    class func setLanguage(_ language: String) {
        Bundle.once
        
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let langBundle = Bundle(path: path) else {
            print("❌ Failed to find bundle path for language: \(language)")
            return
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey, langBundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private class LanguageBundle: Bundle {
        override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
            guard let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle else {
                return super.localizedString(forKey: key, value: value, table: tableName)
            }
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}
