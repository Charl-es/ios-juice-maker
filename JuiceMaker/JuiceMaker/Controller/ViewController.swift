//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    var juiceMaker = JuiceMaker()

    @IBOutlet weak var strawberryLabel: UILabel!
    @IBOutlet weak var bananaLabel: UILabel!
    @IBOutlet weak var pineappleLabel: UILabel!
    @IBOutlet weak var kiwiLabel: UILabel!
    @IBOutlet weak var mangoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func clickStock(_ sender: Any) {
        if let viewController = self.storyboard?.instantiateViewController(identifier: "StockViewController") {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func configureFristView() {
        let stock = juiceMaker.fruitStore.fruitStock.compactMapValues { stock in
            return String(stock)
        }
        
        strawberryLabel.text = stock[.strawberry]
        bananaLabel.text = stock[.banana]
        kiwiLabel.text = stock[.kiwi]
        pineappleLabel.text = stock[.pineapple]
        mangoLabel.text = stock[.mango]
    }
    
    func orderJuice(to juice: Juice) {
        do {
            try juiceMaker.createJuice(juice: juice)
            
        } catch FruitStoreError.outOfStock {
            
        } catch {
            print(error)
        }
    }
}

