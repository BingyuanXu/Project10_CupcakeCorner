//
//  ContentView.swift
//  project10CupcakeCorner
//
//  Created by bingyuan xu on 2020-06-06.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI

class Order: ObservableObject,Codable {
  
  enum CodingKeys: CodingKey {
    case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(type, forKey: .type)
    try container.encode(quantity, forKey: .quantity)
    try container.encode(extraFrosting, forKey: .extraFrosting)
    try container.encode(addSprinkles, forKey: .addSprinkles)
    try container.encode(name, forKey: .name)
    try container.encode(streetAddress, forKey: .streetAddress)
    try container.encode(city, forKey: .city)
    try container.encode(zip, forKey: .zip)
    
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    type = try container.decode(Int.self, forKey: .type)
    quantity = try container.decode(Int.self, forKey: .quantity)
    
    extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
    addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
    
    name = try container.decode(String.self, forKey: .name)
    streetAddress = try container.decode(String.self, forKey: .streetAddress)
    city = try container.decode(String.self, forKey: .city)
    zip = try container.decode(String.self, forKey: .zip)
  }
  
  
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
  @Published var name = ""
  @Published var streetAddress = ""
  @Published var city = ""
  @Published var zip = ""
  
  var hasValidAddress: Bool {
    if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
      return false
    }
    
    return true
  }
  
  var cost: Double {
    var cost = Double(quantity) * 2
    cost += (Double(type) / 2)
    
    if extraFrosting {
      cost += Double(quantity)
    }
    if addSprinkles {
      cost += Double(quantity) / 2
    }
    return cost
  }
  
  init() {}
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
