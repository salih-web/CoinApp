//
//  CoinManager.swift
//  CoinApp
//
//  Created by Muhammed Salih Bulut on 11.03.2024.
//

import UIKit


struct CoinManager{
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "A4AFE11C-626E-4C41-B278-3DDBE82BAB91"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","TRY","IDR","USD"]
    let coinArray = ["BTC","BNB","XRP","SOL","AVAX","ETH","PEPE","DOGE","ARB","EDU","MINA","AR","DOT","TWT"]
    
    
    func getCoinPrice(for currency: String, coin: String){
        
        let urlString = "\(baseURL)/\(coin)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                let dataAsString = String(data: data!, encoding: .utf8)
                print(dataAsString!)
            
            }
            task.resume()
        }
    }
}
