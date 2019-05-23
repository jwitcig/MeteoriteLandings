//
//  MeteoriteLanding.swift
//  Meteorite Landings
//
//  Created by Jonah Witcig on 5/22/19.
//  Copyright © 2019 University of Missouri. All rights reserved.
//

import Foundation

/*
 Represents a single meteorite landing.
*/
struct MeteoriteLanding: Decodable {
    
    // Translating between the names of the properties on our struct
    // and the keys in the JSON under which you can find the data
    private enum CodingKeys: String, CodingKey {
        case name
        case id
        case nametype
        case classification = "recclass"
        case mass
        case observed = "fall"
        case date = "year"
        case latitude = "reclat"
        case longitude = "reclong"
        case geolocation
    }
    
    // Our properties, most are of type String, as called for by the JSON data.
    // latitude and longitude are both defined as Strings as well, although you
    // might expect them to be of type Double. The Geolocation struct provides
    // Double-typed represendations of these two fields.
    let name: String
    let id: String
    let nametype: String
    let classification: String
    let mass: String?
    let observed: String            // observed falling or discovered afterward
    let date: Date?
    let latitude: String?
    let longitude: String?
    let geolocation: Geolocation?   // alternate representation of latitude and longitude
}
