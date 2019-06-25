//
//  UITabBarControllerExtensions.swift
//  CustomTabBar
//
//  Created by David Anderson on 2019-06-21.
//  Copyright © 2019 Robots & Pencils Inc. All rights reserved.
//

import UIKit

enum TabBarStyling {
    case iOS13BrokenAPI
    case darkModeCompatibleWithOldAPI
}

// START HERE BY CHANGING WHICH STYLING PATH YOU WANT TO SEE
let tabBarStyling: TabBarStyling = .iOS13BrokenAPI
// Then launch the app in an iOS 13 simulator and observe the lack of customization of the tab bar items
// Also try togging the environment override for dark mode
// Should also support iOS 12 (excluding dark mode)

extension UITabBarController {
    static func customizedTabBarController() -> UITabBarController {
        
        let tabBarController: UITabBarController
        if tabBarStyling == .iOS13BrokenAPI {
            tabBarController = UITabBarController.init()
            if #available(iOS 13.0, *) {
                modernTabBarCustomization(tabBarController: tabBarController)
            } else {
                legacyTabBarCustomization(tabBarController: tabBarController)
            }
        } else {
            tabBarController = CustomTabBarController.init()
            legacyTabBarCustomization(tabBarController: tabBarController)
        }
        
        return tabBarController
    }

    @available(iOS 13.0, *)
    static func modernTabBarCustomization(tabBarController: UITabBarController) {
        let appearance = UITabBarAppearance(barAppearance: tabBarController.tabBar.standardAppearance)
        
        // This DOES appear to have an effect
        appearance.backgroundColor = UIColor.systemYellow
        
        // These DO NOT appear to have any effect
        appearance.stackedLayoutAppearance.normal.iconColor = .systemPink
        appearance.stackedLayoutAppearance.selected.iconColor = .systemOrange
        // These DO NOT appear to have any effect
        appearance.inlineLayoutAppearance.normal.iconColor = .systemPink
        appearance.inlineLayoutAppearance.selected.iconColor = .systemOrange
        // These DO NOT appear to have any effect
        appearance.compactInlineLayoutAppearance.normal.iconColor = .systemPink
        appearance.compactInlineLayoutAppearance.selected.iconColor = .systemOrange
        
        let normalAppearance = appearance.stackedLayoutAppearance.normal
        let selectedAppearance = appearance.stackedLayoutAppearance.selected
        
        normalAppearance.iconColor = .systemPink
        selectedAppearance.iconColor = .systemOrange

        // Can't do it this way because `normal` and `selected are `get` only
        // var normal: UITabBarItemStateAppearance { get }
        // if we try we get a `Cannot assign to property: 'normal' is a get-only property`
//        appearance.stackedLayoutAppearance.normal = normalAppearance
//        appearance.stackedLayoutAppearance.selected = selectedAppearance
//        appearance.inlineLayoutAppearance.normal = normalAppearance
//        appearance.inlineLayoutAppearance.selected = selectedAppearance
//        appearance.compactInlineLayoutAppearance.normal = normalAppearance
//        appearance.compactInlineLayoutAppearance.selected = selectedAppearance

        let stackedItemAppearance = UITabBarItemAppearance(style: .stacked)
        let inlineItemAppearance = UITabBarItemAppearance(style: .inline)
        let compactInlineItemAppearance = UITabBarItemAppearance(style: .compactInline)
        
        // Even if I create my own item appearances from scratch, I still can't customize them
        // var normal: UITabBarItemStateAppearance { get }
        // if we try we get a `Cannot assign to property: 'normal' is a get-only property`
//        stackedItemAppearance.normal = normalAppearance
//        stackedItemAppearance.selected = selectedAppearance
//        inlineItemAppearance.normal = normalAppearance
//        inlineItemAppearance.selected = selectedAppearance
//        compactInlineItemAppearance.normal = normalAppearance
//        compactInlineItemAppearance.selected = selectedAppearance
        
        tabBarController.tabBar.standardAppearance = appearance
    }
    
    static func legacyTabBarCustomization(tabBarController: UITabBarController) {
        
        // if this is used with iOS 13, changing to/from dark mode has zero effect if this is a stock UITabBarController
        if #available(iOS 13.0, *) {
            tabBarController.tabBar.barTintColor = .systemGray2
            tabBarController.tabBar.tintColor = .systemPurple
            tabBarController.tabBar.unselectedItemTintColor = .systemGray
        } else {
            // Fallback on earlier versions
            tabBarController.tabBar.barTintColor = .systemGreen
            tabBarController.tabBar.tintColor = .systemPurple
            tabBarController.tabBar.unselectedItemTintColor = .systemPink
        }
    }
}

// If we subclass UITabBarController and override `traitCollectionDidChange` then we can use legacy tabBarController customization while supporting dark mode on iOS 13
class CustomTabBarController: UITabBarController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            UITabBarController.legacyTabBarCustomization(tabBarController: self)
        }
    }
}
