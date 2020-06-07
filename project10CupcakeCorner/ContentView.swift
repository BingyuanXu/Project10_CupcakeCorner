//
//  ContentView.swift
//  project10CupcakeCorner
//
//  Created by bingyuan xu on 2020-06-06.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var username = ""
  @State private var email = ""
  var disableForm: Bool {
      username.count < 5 || email.count < 5
  }
  var body: some View {
    
    
    Form {
      Section {
        TextField("Username", text: $username)
        TextField("email", text: $email)
      }
      
      Section {
        Button("Create account") {
          print("Creating account…")
        }
        .disabled(self.username.isEmpty || self.email.isEmpty || disableForm)
      }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
