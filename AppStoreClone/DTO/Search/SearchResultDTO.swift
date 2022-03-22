//
//  SearchResultDTO.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/21.
//

import Foundation

struct SearchResultDTO: Codable {
    let resultCount: Int
    let results: [Result]
}

extension SearchResultDTO {
    init(data: Data) throws {
            self = try newJSONDecoder().decode(SearchResultDTO.self, from: data)
        }

        init(_ json: String, using encoding: String.Encoding = .utf8) throws {
            guard let data = json.data(using: encoding) else {
                throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
            }
            try self.init(data: data)
        }

        init(fromURL url: URL) throws {
            try self.init(data: try Data(contentsOf: url))
        }

        func with(
            resultCount: Int? = nil,
            results: [Result]? = nil
        ) -> SearchResultDTO {
            return SearchResultDTO(
                resultCount: resultCount ?? self.resultCount,
                results: results ?? self.results
            )
        }

        func jsonData() throws -> Data {
            return try newJSONEncoder().encode(self)
        }

        func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
            return String(data: try self.jsonData(), encoding: encoding)
        }
}

struct Result: Codable {
    let ipadScreenshotUrls: [String]
    let appletvScreenshotUrls: [JSONAny]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistViewURL: String
    let screenshotUrls: [String]
    let features: [String]
    let supportedDevices, advisories: [String]
    let isGameCenterEnabled: Bool
    let kind: String
    let minimumOSVersion, trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes: String
    let sellerURL: String?
    let formattedPrice: String?
    let contentAdvisoryRating: String
    let averageUserRatingForCurrentVersion: Double
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let trackViewURL: String
    let trackContentRating: String
    let bundleID: String
    let trackID: Int
    let trackName: String
    let releaseDate: String
    let primaryGenreName: String
    let genreIDS: [String]
    let isVppDeviceBasedLicensingEnabled: Bool
    let sellerName: String
    let currentVersionReleaseDate: String
    let releaseNotes: String?
    let primaryGenreID: Int
    let currency: String
    let resultDescription: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Double
    let version: String
    let wrapperType: String
    let userRatingCount: Int
    
    enum CodingKeys: String, CodingKey {
        case artworkUrl60, appletvScreenshotUrls, artworkUrl512, ipadScreenshotUrls, screenshotUrls, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case features, supportedDevices, advisories, isGameCenterEnabled, kind
        case minimumOSVersion = "minimumOsVersion"
        case trackCensoredName, languageCodesISO2A, fileSizeBytes
        case sellerURL = "sellerUrl"
        case formattedPrice, contentAdvisoryRating, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, averageUserRating
        case trackViewURL = "trackViewUrl"
        case trackContentRating
        case bundleID = "bundleId"
        case trackID = "trackId"
        case trackName, releaseDate, primaryGenreName
        case genreIDS = "genreIds"
        case isVppDeviceBasedLicensingEnabled, sellerName, currentVersionReleaseDate, releaseNotes
        case primaryGenreID = "primaryGenreId"
        case currency, version, wrapperType
        case artistID = "artistId"
        case artistName, genres, price
        case resultDescription = "description"
        case userRatingCount
    }
}

extension Result {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Result.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        ipadScreenshotUrls: [String]? = nil,
        appletvScreenshotUrls: [JSONAny]? = nil,
        artworkUrl60: String? = nil,
        artworkUrl512: String? = nil,
        artworkUrl100: String? = nil,
        artistViewURL: String? = nil,
        screenshotUrls: [String]? = nil,
        features: [String]? = nil,
        supportedDevices: [String]? = nil,
        advisories: [String]? = nil,
        isGameCenterEnabled: Bool? = nil,
        kind: String? = nil,
        minimumOSVersion: String? = nil,
        trackCensoredName: String? = nil,
        languageCodesISO2A: [String]? = nil,
        fileSizeBytes: String? = nil,
        sellerURL: String?? = nil,
        formattedPrice: String? = nil,
        contentAdvisoryRating: String? = nil,
        averageUserRatingForCurrentVersion: Double? = nil,
        userRatingCountForCurrentVersion: Int? = nil,
        averageUserRating: Double? = nil,
        trackViewURL: String? = nil,
        trackContentRating: String? = nil,
        bundleID: String? = nil,
        trackID: Int? = nil,
        trackName: String? = nil,
        releaseDate: String? = nil,
        primaryGenreName: String? = nil,
        genreIDS: [String]? = nil,
        isVppDeviceBasedLicensingEnabled: Bool? = nil,
        sellerName: String? = nil,
        currentVersionReleaseDate: String? = nil,
        releaseNotes: String? = nil,
        primaryGenreID: Int? = nil,
        currency: String? = nil,
        resultDescription: String? = nil,
        artistID: Int? = nil,
        artistName: String? = nil,
        genres: [String]? = nil,
        price: Double? = nil,
        version: String? = nil,
        wrapperType: String? = nil,
        userRatingCount: Int? = nil
    ) -> Result {
        return Result(
            ipadScreenshotUrls: ipadScreenshotUrls ?? self.ipadScreenshotUrls,
            appletvScreenshotUrls: appletvScreenshotUrls ?? self.appletvScreenshotUrls,
            artworkUrl60: artworkUrl60 ?? self.artworkUrl60,
            artworkUrl512: artworkUrl512 ?? self.artworkUrl512,
            artworkUrl100: artworkUrl100 ?? self.artworkUrl100,
            artistViewURL: artistViewURL ?? self.artistViewURL,
            screenshotUrls: screenshotUrls ?? self.screenshotUrls,
            features: features ?? self.features,
            supportedDevices: supportedDevices ?? self.supportedDevices,
            advisories: advisories ?? self.advisories,
            isGameCenterEnabled: isGameCenterEnabled ?? self.isGameCenterEnabled,
            kind: kind ?? self.kind,
            minimumOSVersion: minimumOSVersion ?? self.minimumOSVersion,
            trackCensoredName: trackCensoredName ?? self.trackCensoredName,
            languageCodesISO2A: languageCodesISO2A ?? self.languageCodesISO2A,
            fileSizeBytes: fileSizeBytes ?? self.fileSizeBytes,
            sellerURL: sellerURL ?? self.sellerURL,
            formattedPrice: formattedPrice ?? self.formattedPrice,
            contentAdvisoryRating: contentAdvisoryRating ?? self.contentAdvisoryRating,
            averageUserRatingForCurrentVersion: averageUserRatingForCurrentVersion ?? self.averageUserRatingForCurrentVersion,
            userRatingCountForCurrentVersion: userRatingCountForCurrentVersion ?? self.userRatingCountForCurrentVersion,
            averageUserRating: averageUserRating ?? self.averageUserRating,
            trackViewURL: trackViewURL ?? self.trackViewURL,
            trackContentRating: trackContentRating ?? self.trackContentRating,
            bundleID: bundleID ?? self.bundleID,
            trackID: trackID ?? self.trackID,
            trackName: trackName ?? self.trackName,
            releaseDate: releaseDate ?? self.releaseDate,
            primaryGenreName: primaryGenreName ?? self.primaryGenreName,
            genreIDS: genreIDS ?? self.genreIDS,
            isVppDeviceBasedLicensingEnabled: isVppDeviceBasedLicensingEnabled ?? self.isVppDeviceBasedLicensingEnabled,
            sellerName: sellerName ?? self.sellerName,
            currentVersionReleaseDate: currentVersionReleaseDate ?? self.currentVersionReleaseDate,
            releaseNotes: releaseNotes ?? self.releaseNotes,
            primaryGenreID: primaryGenreID ?? self.primaryGenreID,
            currency: currency ?? self.currency,
            resultDescription: resultDescription ?? self.resultDescription,
            artistID: artistID ?? self.artistID,
            artistName: artistName ?? self.artistName,
            genres: genres ?? self.genres,
            price: price ?? self.price,
            version: version ?? self.version,
            wrapperType: wrapperType ?? self.wrapperType,
            userRatingCount: userRatingCount ?? self.userRatingCount
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

