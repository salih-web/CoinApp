//
//  View2.swift
//  CoinApp
//
//  Created by Muhammed Salih Bulut on 30.05.2024.
//

import WebKit
import SwiftUI

struct View2: View {
    
    let url: String
    
    var body: some View {
        WebView(urlString: url)
    }
}

#Preview {
    View2(url: "https://coinmarketcap.com/charts/")
}

