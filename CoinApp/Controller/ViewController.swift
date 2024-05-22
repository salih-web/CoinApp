//
//  ViewController.swift
//  CoinApp
//
//  Created by Muhammed Salih Bulut on 11.03.2024.
//

import UIKit
import Charts

class ViewController: UIViewController,ChartViewDelegate {
  
    @IBOutlet weak var coinPicker: UIPickerView!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    var coinManager = CoinManager()
        var lineChart = LineChartView()
        var priceDataEntries: [ChartDataEntry] = []
        var fetchCount = 0
        var timer: Timer?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            lineChart.delegate = self
            coinManager.delegate = self
            coinPicker.delegate = self
            coinPicker.dataSource = self
            currencyPicker.delegate = self
            currencyPicker.dataSource = self
            
            setupLineChart()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
            lineChart.center = view.center
            view.addSubview(lineChart)
        }
        
        func setupLineChart() {
            lineChart.noDataText = "No data available"
            lineChart.chartDescription.text = "Price Chart"
        }
        
        func resetChart() {
            priceDataEntries.removeAll()
            fetchCount = 0
            updateChart()
            startFetchingData()
        }
        
        func startFetchingData() {
            timer?.invalidate() // Stop any existing timer
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fetchData), userInfo: nil, repeats: true)
        }
        
        @objc func fetchData() {
            if fetchCount < 10{
                if let selectedCoin = coinLabel.text, let selectedCurrency = currencyLabel.text {
                    coinManager.getCoinPrice(currency: selectedCurrency, coin: selectedCoin)
                }
            } else {
                timer?.invalidate()
            }
        }
        
    func updateChart() {
        let set = LineChartDataSet(entries: priceDataEntries, label: "Price")
        set.drawFilledEnabled = true
        set.fillColor = .blue
        set.fillAlpha = 0.5

        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }
    }

    //MARK: - PickerView Delegate and DataSource
    extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
            if pickerView == coinPicker {
                let selectedCoin = coinManager.currencyArray[row]
                currencyLabel.text = selectedCoin
            } else if pickerView == currencyPicker {
                let selectedCurrency = coinManager.coinArray[row]
                coinLabel.text = selectedCurrency
            }
            if let selectedCoin = coinLabel.text, let selectedCurrency = currencyLabel.text {
                coinManager.getCoinPrice(currency: selectedCurrency, coin: selectedCoin)
                resetChart() // Reset and start fetching data again
            }
        }
    }

    //MARK: - CoinManagerDelegate
    extension ViewController: CoinManagerDelegate {
        func didUpdatePrice(price: String, currency: String, coin: String) {
            DispatchQueue.main.async {
                self.priceLabel.text = price
                
                if let priceValue = Double(price) {
                    let newEntry = ChartDataEntry(x: Double(self.priceDataEntries.count), y: priceValue)
                    self.priceDataEntries.append(newEntry)
                    self.updateChart()
                }
                
                self.fetchCount += 1
            }
        }
        
        func didFailWithError(error: any Error) {
            print(error)
        }
    }





