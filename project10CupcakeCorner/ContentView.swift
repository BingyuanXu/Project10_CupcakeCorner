//
//  ContentView.swift
//  project10CupcakeCorner
//
//  Created by bingyuan xu on 2020-06-06.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI

//class User: Codable, ObservableObject {
//  @Published var name = "Bingyuan"
//  @Published var gender = "male"
//
//  enum Codingkeys: CodingKey {
//    case name
//    case gender
//  }
//
//  func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: Codingkeys.self)
//    try container.encode(name, forKey: .name)
//    try container.encode(gender, forKey: .gender)
//  }
//
//  required init(from decoder: Decoder) throws { //decoder 接收所有数据
//    // publish class可以继承，每次继承需要改写init适应自己的中的数据，required 关键字就是要求继承的时候重写，可以用final关键字，不允许继承
//    let container = try decoder.container(keyedBy: Codingkeys.self)
//    //we ask our Decoder instance for a container matching all the coding keys we already set in our CodingKey struct
//    name = try container.decode(String.self, forKey: .name)
//    gender = try container.decode(String.self, forKey: .gender)
//  }
//}


class User: ObservableObject, Codable {
  @Published var name = "Bingyuan"
  
  enum CodingKeys: CodingKey {
    case name
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
     name = try container.decode(String.self, forKey: .name)
  }
}

struct Responses: Codable {
  var results: [Result]
}

struct Result: Codable {
  var trackId: Int
  var trackName: String
  var collectionName: String
}



struct ContentView: View {
   @State private var results = [Result]()
   @State var a = ""

  func loadData() {
    guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
      print("Invalid URL")
      return }
    
    let request = URLRequest(url: url)
    
    URLSession.shared.dataTask(with: request) { data, request,error in
      let decoder = JSONDecoder()
      if let data = data {
        if let decodeResponse = try? decoder.decode(Responses.self, from: data) {
          DispatchQueue.main.sync {
            self.results = decodeResponse.results
          }
          return
        }
      }
      print("Fetch failed: \(error?.localizedDescription ?? "Unknown")")
      
    }.resume()
    
   
  }


  var body: some View {
 
 
    List(results, id: \.trackId) { item in
      VStack(alignment: .leading) {
        Text(item.trackName)
          .font(.headline)
        Text(item.collectionName)


      }
    }
      .onAppear(perform: loadData) //We want that to be run as soon as our List is shown, so you should add this modifier to the List:
  }

}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
