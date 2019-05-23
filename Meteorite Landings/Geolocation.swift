//
//  Geolocation.swift
//  Meteorite Landings
//
//  Created by Jonah Witcig on 5/22/19.
//  Copyright © 2019 University of Missouri. All rights reserved.
//

import Foundation

/*
 A more strongly typed reprentation of the geolocation data
 found in a MeteoriteLanding struct (Uses Double instead of
 String).
*/
struct Geolocation: Decodable {
    let type: String
    let coordinates: [Double]
}
