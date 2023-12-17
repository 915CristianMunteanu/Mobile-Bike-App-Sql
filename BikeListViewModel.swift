//
//  BikeListViewModel.swift
//  Bike-App
//
//  Created by Munteanu, Cristian on 12.11.2023.
//

import Foundation
import SQLite3

class BikeListViewModel: ObservableObject {
    @Published var bikes: [Bike] = []
    private var dbManager = BikeDatabaseManager()
    
    init() {
        loadBikesFromDatabase()
    }
    
    private func loadBikesFromDatabase() {
        bikes = dbManager.fetchBikes()
    }
    
    func addBike(bike: Bike) {
        dbManager.addBike(bike: bike)
        loadBikesFromDatabase()
    }
    
    func deleteBike(bike: Bike) {
        if let id = bike.id {
            dbManager.deleteBike(byId: id)
            loadBikesFromDatabase()
        }
    }
    
    func updateBike(bike: Bike) {
        dbManager.updateBike(bike)
        loadBikesFromDatabase()
    }
}
