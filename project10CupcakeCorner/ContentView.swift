//
//  ContentView.swift
//  project10CupcakeCorner
//
//  Created by bingyuan xu on 2020-06-06.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI

 class User: Codable, ObservableObject {
  @Published var name = "Bingyuan"
    @Published var gender = "male"
  
  enum Codingkeys: CodingKey {
    case name
    case gender
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Codingkeys.self)
    try container.encode(name, forKey: .name)
      try container.encode(gender, forKey: .gender)
  }
  
  required init(from decoder: Decoder) throws { //decoder 接收所有数据
    // publish class可以继承，每次继承需要改写init适应自己的中的数据，required 关键字就是要求继承的时候重写，可以用final关键字，不允许继承
   let container = try decoder.container(keyedBy: Codingkeys.self)
    //we ask our Decoder instance for a container matching all the coding keys we already set in our CodingKey struct
    name = try container.decode(String.self, forKey: .name)
    gender = try container.decode(String.self, forKey: .gender)
  }
}


struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
