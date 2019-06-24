//
//  ContentView.swift
//  SwiftUI+XCUITest
//
//  Created by Brandon Evans on 2019-06-24.
//  Copyright © 2019 Robots and Pencils, Inc. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView : View {
    @ObjectBinding var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Username")
                TextField($viewModel.username)
                    // The accessibilityElement modifier seems to be necessary to have an identifier take effect on a TextField
                    .accessibilityElement()
                    .accessibility(identifier: "login.username")
            }
            HStack {
                Text("Password")
                TextField($viewModel.password)
                    // The accessibilityElement modifier seems to be necessary to have an identifier take effect on a TextField
                    .accessibilityElement()
                    .accessibility(identifier: "login.password")
            }
            Button(action: {
                print("Logged In")
            }, label: { Text("Log In") })
                .accessibility(identifier: "login.primaryAction")
                .disabled(!viewModel.canLogIn)
                .padding([.top, .bottom])
                .relativeWidth(1.0)
            Spacer()
        }
        .padding()
    }
}

class LoginViewModel: BindableObject {
    var username: String = "" {
        didSet {
            didChange.send(())
        }
    }

    var password: String = "" {
        didSet {
            didChange.send(())
        }
    }

    var canLogIn: Bool {
        return !username.isEmpty && !password.isEmpty
    }

    let didChange = PassthroughSubject<Void, Never>()

    func logIn(completion: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion?()
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
