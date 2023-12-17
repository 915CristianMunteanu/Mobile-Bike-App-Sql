//
//  ContentView.swift
//  Bike-App
//
//  Created by Munteanu, Cristian on 12.11.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bikeListViewModel = BikeListViewModel()
    @State private var isAddingBike = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($bikeListViewModel.bikes) { $bike in
                        NavigationLink(destination: BikeDetailsView(bike: bike)) {
                            BikeListCell(bike: bike)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        let bikesToDelete = indexSet.map { bikeListViewModel.bikes[$0] }
                        for bike in bikesToDelete {
                            bikeListViewModel.deleteBike(bike: bike)
                        }
                    })
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .navigationBarTitle("Bikes", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    isAddingBike = true
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                }
            )
            .sheet(isPresented: $isAddingBike) {
                AddBikeView(bike: Bike())
            }
        }
        .environmentObject(bikeListViewModel)
    }
}
