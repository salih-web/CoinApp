//
//  CoinManager.swift
//  CoinApp
//
//  Created by Muhammed Salih Bulut on 11.03.2024.
//

import UIKit


protocol CoinManagerDelegate{
    func didUpdatePrice(price:String, currency:String, coin:String)
    func didFailWithError(error:Error)
}

struct CoinManager{
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "API KEY HERE"
    
   
    let currencyArray = ["USD", "TRY","CAD","CNY","EUR","GBP","USD","TRY","AUD"]
    let coinArray = ["BTC","BNB","XRP","SOL","AVAX","ETH","PEPE","DOGE","ARB","EDU","MINA","AR","DOT","TWT"]
    
    var delegate: CoinManagerDelegate?
    
    
    func getCoinPrice(for currency: String, coin: String){
        
        let urlString = "\(baseURL)/\(coin)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data{
                    if let coinPrice = self.parseJSON(data: safeData){
                        let priceString = String(format: "%.6f", coinPrice)
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency,coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(data:Data)-> Double?{
        //Create a JSONDecoder
        let decoder = JSONDecoder()
        do{
            //try to decode the data using the CoinData structure
            let decodedData = try decoder.decode(CoinData.self, from: data)
            //Get the last property from the decoded data.
            let rate = decodedData.rate
            print(rate)
            return rate
        }
        catch{
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
}
