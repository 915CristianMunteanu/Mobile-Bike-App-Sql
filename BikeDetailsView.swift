//
//  BikeDetailsView.swift
//  Bike-App
//
//  Created by Munteanu, Cristian on 12.11.2023.
//

import SwiftUI

struct BikeDetailsView: View {
    @EnvironmentObject var bikeListViewModel: BikeListViewModel
    @State var bike: Bike
    @State private var selectedColorIndex = 0
    @State var brand: String
    @State var model: String
    @State var color: Colors
    @State var serviceDue: Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Bike Details")) {
                    HStack {
                        Text("Brand")
                        Spacer()
                        TextField("Brand", text: $brand)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack {
                        Text("Model")
                        Spacer()
                        TextField("Model", text: $model)
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
                        TextField("Service In", value: $serviceDue, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                }
            }
            .navigationBarTitle("Bike Details", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                bike.color = Colors.allCases[selectedColorIndex]
                bike.model = model
                bike.brand = brand
                bike.color = color
                bike.serviceDue = serviceDue
                bikeListViewModel.updateBike(bike: bike)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    init(bike: Bike) {
        self._bike = State(initialValue: bike)
        self._brand = State(initialValue: bike.brand)
        self._model = State(initialValue: bike.model)
        self._color = State(initialValue: bike.color)
        self._serviceDue = State(initialValue: bike.serviceDue)
    }
}

