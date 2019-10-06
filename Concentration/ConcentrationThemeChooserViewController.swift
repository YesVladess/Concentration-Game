//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by YesVladess on 06.10.2019.
//  Copyright © 2019 Влад Кононенко. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    let themes = ["Flags", "Winter", "Faces"]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes.firstIndex(of: themeName) {
                cvc.theme = themes[theme]
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes.firstIndex(of: themeName) {
                cvc.theme = themes[theme]
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    // MARK: - Navigation
    
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes.firstIndex(of: themeName) {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = themes[theme]
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
    
}
