//
//  GeoJSON.swift
//  Earthquakes-iOS
//
//  Created by Teff on 2023/05/31.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation

struct GeoJSON: Decodable {
    private enum RootCodingKeys: String, CodingKey {
        case features
    }
    private enum FeatureCodingKeys: String, CodingKey {
        case properties
    }
    private(set) var quakes: [Quake] = [] // Code within the GeoJSON structure can modify the quakes property, but code outside the structure can only read the property value
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var featureContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features)
        
        while !featureContainer.isAtEnd {
            let propertiesContainer = try featureContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
            
            // Using try? ignores quakes with missing data
            if let properties = try? propertiesContainer.decode(Quake.self, forKey: .properties) {
                quakes.append(properties)
            }
        }
    }
}
