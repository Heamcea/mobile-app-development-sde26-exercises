//
//  ContentView.swift
//  MADExercises
//
//  Created by Hamza Ahmad
//

import SwiftUI

struct ContentView: View {
    
    @State
    private var email = ""
    
    @State
    private var password = ""
    
    @State
    private var isLoading = false
    
    @State
    private var alertTitle = ""
    
    @State
    private var alertMessage = ""
    
    @State
    private var showAlert = false
    
    private enum Field {
        case email
        case password
    }
    
    @FocusState
    private var focusedField: Field?
    
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .password
                }
                .textFieldStyle(.roundedBorder)
                .font(.title2)
                .background(Color.gray.opacity(0.5))
                .disabled(isLoading)
            
            SecureField("Password", text: $password)
                .textContentType(.password)
                .focused($focusedField, equals: .password)
                .submitLabel(.go)
                .onSubmit {
                    login()
                }
                .textFieldStyle(.roundedBorder)
                .font(.title2)
                .background(Color.gray.opacity(0.5))
                .disabled(isLoading)
            
            if (isLoading){
                ProgressView("Loading ...")
                    .progressViewStyle(.circular)
            }
            
            
            Button("Login")
            {
                login()
            }
            .disabled(isLoading)
        }
        .padding()
        .alert(alertTitle, isPresented: $showAlert){
            Button("OK", role: .cancel){
            }
        } message: {
            Text(alertMessage)
        }
    }
    private func login() {
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            displayAlert("Error", "Missing Email")
            return
        }
        guard !password.isEmpty else {
            displayAlert("Error", "Missing Password")
            return
        }
        
        isLoading = true
        focusedField = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            let expectedEmail = "test@hcw.com"
            let expectedPassword = "campusWien1100"
            
            if(email == expectedEmail && password == expectedPassword)
            {
                displayAlert("Success", "Login sucessful!")
            } else {
                displayAlert("Failed Login", "Email or Password is incorrect!")
            }
            isLoading = false
        }
    }
    private func displayAlert(_ title: String,_ message: String){
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}


#Preview {
    ContentView()
}
