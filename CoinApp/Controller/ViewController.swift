//
//  ViewController.swift
//  CoinApp
//
//  Created by Muhammed Salih Bulut on 11.03.2024.
//

import UIKit
import Charts

class ViewController: UIViewController {
  
    @IBOutlet weak var coinPicker: UIPickerView!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    
    var coinManager = CoinManager()
    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChart.delegate = self
        coinManager.delegate = self
        coinPicker.delegate = self
        coinPicker.dataSource = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        for x in 0...15{
            entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        let set = LineChartDataSet(entries: entries)
        let data = LineChartData(dataSet: set)
        lineChart.data = data
        
    }
}
//MARK: - PickerView Delegate and DataSource
/* pickerView'ların yeri karıştığı için yeniden telefonun interface ile uğraşmak yerine
 if-else döngülerinde her pickerView diğer array ile eşleştirdim.
 labellar'da değiştirildi döngü sırasında.
*/
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == coinPicker {
            return coinManager.currencyArray.count
        } else {
            return coinManager.coinArray.count
        }
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == coinPicker {
            return coinManager.currencyArray[row]
            
        } else {
            return coinManager.coinArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == coinPicker{
            let selectedCoin = coinManager.currencyArray[row]
            currencyLabel.text = selectedCoin
        }else if pickerView == currencyPicker{
            let selectedCurrency = coinManager.coinArray[row]
            coinLabel.text = selectedCurrency
        }
        if let selectedCoin = coinLabel.text , let selectedCurrency = currencyLabel.text{
            coinManager.getCoinPrice(currency: selectedCurrency, coin: selectedCoin)
        }
    }
}
//MARK: -CoinManagerDelegate

extension ViewController: CoinManagerDelegate{
    func didUpdatePrice(price: String, currency: String, coin: String) {
        DispatchQueue.main.async {
            
            self.priceLabel.text = price
            
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
}

//MARK: -ChartViewDelegate

extension ViewController:ChartViewDelegate{
    
    
}

