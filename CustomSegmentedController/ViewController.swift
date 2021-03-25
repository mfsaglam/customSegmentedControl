//
//  ViewController.swift
//  CustomSegmentedController
//
//  Created by Fatih Sağlam on 24.03.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectorStyle = .highlightedOnly
    }
    @IBAction func segmentSelected(_ sender: CustomSegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print(0)
        case 1:
            print(1)
        case 2:
            print(2)
        default:
            print("nope")
        }
    }
    

}

