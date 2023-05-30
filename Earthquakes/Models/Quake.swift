/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A structure for representing quake data.
*/

import Foundation

struct Quake {
    let magnitude: Double
    let type: String
    let place: String
    let time: Date
    let tsunami: Int
    let code: String
    let detail: URL
}

extension Quake: Identifiable {
    var id: String { code }
}

extension Quake: Decodable {
    private enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case type
        case place
        case time
        case tsunami
        case code
        case detail
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawMagnitude = try? values.decode(Double.self, forKey: .magnitude)
        let rawType = try? values.decode(String.self, forKey: .type)
        let rawPlace = try? values.decode(String.self, forKey: .place)
        let rawTime = try? values.decode(Date.self, forKey: .time)
        let rawTsunami = try? values.decode(Int.self, forKey: .tsunami)
        let rawCode = try? values.decode(String.self, forKey: .code)
        let rawDetail = try? values.decode(URL.self, forKey: .detail)
        
        guard let magnitude = rawMagnitude,
              let type = rawType,
              let place = rawPlace,
              let time = rawTime,
              let tsunami = rawTsunami,
              let code = rawCode,
              let detail = rawDetail
        else {
            throw QuakeError.missingData
        }
        
        self.magnitude = magnitude
        self.type = type
        self.place = place
        self.time = time
        self.tsunami = tsunami
        self.code = code
        self.detail = detail
    }
}
