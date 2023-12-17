//
//  BikeListCell.swift
//  Bike-App
//
//  Created by Munteanu, Cristian on 12.11.2023.
//

import SwiftUI

struct BikeListCell: View {
    let bike: Bike
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(bike.brand)
                        .font(.title)
                    Text(bike.model)
                        .font(.subheadline)
                }
                Spacer()
                VStack {
                    Text("Color: \(bike.color.rawValue)")
                    Text("Service Due: \(bike.serviceDue)")
                }
            }
        }
    }
}

