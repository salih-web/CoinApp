//
//  Controller1.swift
//  CoinApp
//
//  Created by Muhammed Salih Bulut on 27.05.2024.
//

import Foundation
import UIKit
import WebKit
import SwiftUI


class Controller1: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func NewsButton(_ sender: UIButton) {
        let vc = UIHostingController(rootView: SwiftUIView())
        present(vc,animated: true)
    }
}

