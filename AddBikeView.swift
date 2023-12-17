//
//  AddBikeView.swift
//  Bike-App
//
//  Created by Munteanu, Cristian on 12.11.2023.
//

import SwiftUI

struct AddBikeView: View {
    @EnvironmentObject var bikeListViewModel: BikeListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var bike: Bike
    @State private var selectedColorIndex = 0 // Track the selected color index
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Bike Details")) {
                    HStack {
                        Text("Brand")
                        Spacer()
                        TextField("Brand", text: $bike.brand)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack {
                        Text("Model")
                        Spacer()
                        TextField("Model", text: $bike.model)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Picker("Select your color", selection: $selectedColorIndex) {
                        ForEach(0..<Colors.allCases.count, id: \.self) { index in
                            Text(Colors.allCases[index].localizedName)
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                    
                    HStack {
                        Text("Service Due")
                        Spacer()
                        TextField("Service In", value: $bike.serviceDue, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                }
            }
            .navigationTitle("Add a new bike")
            .navigationBarItems(trailing: Button("Save") {
                bike.color = Colors.allCases[selectedColorIndex]
                bikeListViewModel.addBike(bike: bike)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

