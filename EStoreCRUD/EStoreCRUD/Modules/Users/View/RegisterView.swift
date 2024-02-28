//
//  RegisterView.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 27/02/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var createUserVM = AuthViewModel()
    
    // Register textfield
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var avatar = "https://i.pravatar.cc/150?img=31"
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("User information")
                        .font(.headline)
                    
                    Group {
                        TextField("Name", text: $name)
                        TextField("Email", text: $email)
                            .textInputAutocapitalization(.never)
                        
                        SecureField("Password", text: $password)
                    }
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    
                    Button {
                        registeredUser()
                    
                    } label: {
                        Text("Register")
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .navigationTitle(Constant.registerView)
            .alert(isPresented: $createUserVM.registrationSucess) {
                Alert(
                    title: Text("Registration"),
                    message: Text(createUserVM.message),
                    dismissButton: .default(Text("OK"), action: {
                        self.name = ""
                        self.email = ""
                        self.password = ""
                    })
                )
            }
        }
    }
    
    private func registeredUser() {
        Task {
            await createUserVM.registerUser(
                name: name,
                email: email,
                password: password,
                avatar: avatar
            )
        }
    }
}

#Preview {
    RegisterView()
}
