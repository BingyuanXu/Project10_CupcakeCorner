//
//  ContentView.swift
//  project10CupcakeCorner
//
//  Created by bingyuan xu on 2020-06-06.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI

class Order: ObservableObject {
  static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
  @Published var type = 0
  @Published var quantity = 3
  @Published var specialRequestEnabled = false {
    didSet {
      if specialRequestEnabled == false { //interesting
        extraFrosting = false
        addSprinkles = false
      }
    }
  }
  @Published var extraFrosting = false
  @Published var addSprinkles = false
}

struct ContentView: View {
  
  @ObservedObject var order = Order()
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          Picker("Select you cake type", selection: $order.type){
            ForEach(0..<Order.types.count, id: \.self) {
              Text(Order.types[$0])
            }
          }
          
          Stepper(value: $order.quantity, in: 0...20){
            Text("Number of cakes \(order.quantity)")
          }
        }
        Section {
          Toggle(isOn: $order.specialRequestEnabled.animation()) { //animation for fellowing toggles
            Text("Any special requests?")
          }
          
          if order.specialRequestEnabled {
            Toggle(isOn: $order.extraFrosting) {
              Text("Add extra frosting")
            }
            
            Toggle(isOn: $order.addSprinkles) {
              Text("Add extra sprinkles")
            }
          }
        }
        
        Section {
          NavigationLink(destination: AddressView(order: self.order)) {
             Text("Delivery details")
          }
        }
      }
      .navigationBarTitle("Cupcake Corner")
    }
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
