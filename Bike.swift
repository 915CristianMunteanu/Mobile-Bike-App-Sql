//
//  Bike.swift
//  Bike-App
//
//  Created by Munteanu, Cristian on 12.11.2023.
//

import Foundation

struct Bike: Identifiable {
    var id: Int?
    var brand: String
    var model: String
    var color: Colors
    var serviceDue: Int

    init(id: Int? = nil, brand: String = "", model: String = "", color: Colors = .black, serviceDue: Int = 100) {
        self.id = id
        self.brand = brand
        self.model = model
        self.color = color
        self.serviceDue = serviceDue
    }
}
