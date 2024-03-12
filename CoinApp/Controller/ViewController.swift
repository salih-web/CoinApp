//
//  ViewController.swift
//  CoinApp
//
//  Created by Muhammed Salih Bulut on 11.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var coinPicker: UIPickerView!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    let coinManager = CoinManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        coinPicker.delegate = self
        coinPicker.dataSource = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self

    }
    

    
   
    

}
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == coinPicker {
            return coinManager.coinArray.count
        } else {
            return coinManager.currencyArray.count
        }
    }
    
// When we use one of the pickers, the other selection also changes.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == coinPicker {
            return coinManager.coinArray[row]
            
        } else {
            
            return coinManager.currencyArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        let selectedCoin = coinManager.coinArray[row]
        return coinManager.getCoinPrice(for: selectedCurrency, coin: selectedCoin)
    }
    
}


