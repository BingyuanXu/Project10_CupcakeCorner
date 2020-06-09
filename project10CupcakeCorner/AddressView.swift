//
//  AddressView.swift
//  project10CupcakeCorner
//
//  Created by bingyuan xu on 2020-06-08.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI

struct AddressView: View {
  @ObservedObject var order = Order()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}
