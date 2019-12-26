//
//  Heros.swift
//  combineTest
//
//  Created by Gregory SeungHyun Jin on 2019/12/26.
//  Copyright © 2019 Gregory SeungHyun Jin. All rights reserved.
//

import UIKit


class BaseArrayResponse<T:Codable>: NSObject, Codable {
    
    let response : String?
    let resultsfor : String?
    let results : [T]?
    
    enum CodingKeys: String, CodingKey {

        case response = "response"
        case resultsfor = "results-for"
        case results = "results"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decodeIfPresent(String.self, forKey: .response)
        resultsfor = try values.decodeIfPresent(String.self, forKey: .resultsfor)
        results = try values.decodeIfPresent([T].self, forKey: .results)
    }
}

class BaseResponse<T:Codable>: NSObject, Codable {
    let response : String?
    let resultsfor : String?
    let results : T?

    enum CodingKeys: String, CodingKey {

        case response = "response"
        case resultsfor = "results-for"
        case results = "results"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decodeIfPresent(String.self, forKey: .response)
        resultsfor = try values.decodeIfPresent(String.self, forKey: .resultsfor)
        results = try values.decodeIfPresent(T.self, forKey: .results)
    }
}

// MARK: - Heros
struct Heros : Codable,Hashable {
    
    static func == (lhs: Heros, rhs: Heros) -> Bool {
        return lhs.id ?? "" == rhs.id ?? ""
    }
    
    let id : String?
    let name : String?
    let powerstats : Powerstats?
    let biography : Biography?
    let appearance : Appearance?
    let work : Work?
    let connections : Connections?
    let image : Image?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case powerstats = "powerstats"
        case biography = "biography"
        case appearance = "appearance"
        case work = "work"
        case connections = "connections"
        case image = "image"
    }
}

// MARK: - Appearance
struct Appearance : Codable,Hashable {
    let gender : String?
    let race : String?
    let height : [String]?
    let weight : [String]?
    let eyeColor : String?
    let hairColor : String?
    
    static func == (lhs: Appearance, rhs: Appearance) -> Bool {
        return true
    }
    
    enum CodingKeys: String, CodingKey {

        case gender = "gender"
        case race = "race"
        case height = "height"
        case weight = "weight"
        case eyeColor = "eye-color"
        case hairColor = "hair-color"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        race = try values.decodeIfPresent(String.self, forKey: .race)
        height = try values.decodeIfPresent([String].self, forKey: .height)
        weight = try values.decodeIfPresent([String].self, forKey: .weight)
        eyeColor = try values.decodeIfPresent(String.self, forKey: .eyeColor)
        hairColor = try values.decodeIfPresent(String.self, forKey: .hairColor)
    }
}

// MARK: - Biography
struct Biography : Codable,Hashable {
    let fullName : String?
    let alterEgos : String?
    let aliases : [String]?
    let placeOfBirth : String?
    let firstAppearance : String?
    let publisher : String?
    let alignment : String?
    
    static func == (lhs: Biography, rhs: Biography) -> Bool {
        return lhs.fullName == rhs.fullName
    }
    
    enum CodingKeys: String, CodingKey {

        case fullName = "full-name"
        case alterEgos = "alter-egos"
        case aliases = "aliases"
        case placeOfBirth = "place-of-birth"
        case firstAppearance = "first-appearance"
        case publisher = "publisher"
        case alignment = "alignment"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        alterEgos = try values.decodeIfPresent(String.self, forKey: .alterEgos)
        aliases = try values.decodeIfPresent([String].self, forKey: .aliases)
        placeOfBirth = try values.decodeIfPresent(String.self, forKey: .placeOfBirth)
        firstAppearance = try values.decodeIfPresent(String.self, forKey: .firstAppearance)
        publisher = try values.decodeIfPresent(String.self, forKey: .publisher)
        alignment = try values.decodeIfPresent(String.self, forKey: .alignment)
    }
}


// MARK: - Connections
struct Connections : Codable,Hashable {
    let groupAffiliation : String?
    let relatives : String?
    
    static func == (lhs: Connections, rhs: Connections) -> Bool {
        return true
    }
    enum CodingKeys: String, CodingKey {

        case groupAffiliation = "group-affiliation"
        case relatives = "relatives"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        groupAffiliation = try values.decodeIfPresent(String.self, forKey: .groupAffiliation)
        relatives = try values.decodeIfPresent(String.self, forKey: .relatives)
    }
}

// MARK: - Image
struct Image : Codable,Hashable {
    let url : String?
    
    static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.url == rhs.url
    }
    enum CodingKeys: String, CodingKey {

        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}

// MARK: - Powerstats

struct Powerstats : Codable,Hashable {
    
    let intelligence : String?
    let strength : String?
    let speed : String?
    let durability : String?
    let power : String?
    let combat : String?

    
    static func == (lhs: Powerstats, rhs: Powerstats) -> Bool {
        return true
    }
    
    enum CodingKeys: String, CodingKey {

        case intelligence = "intelligence"
        case strength = "strength"
        case speed = "speed"
        case durability = "durability"
        case power = "power"
        case combat = "combat"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intelligence = try values.decodeIfPresent(String.self, forKey: .intelligence)
        strength = try values.decodeIfPresent(String.self, forKey: .strength)
        speed = try values.decodeIfPresent(String.self, forKey: .speed)
        durability = try values.decodeIfPresent(String.self, forKey: .durability)
        power = try values.decodeIfPresent(String.self, forKey: .power)
        combat = try values.decodeIfPresent(String.self, forKey: .combat)
    }
}

// MARK: - Work
struct Work : Codable,Hashable {
    let occupation : String?
    let base : String?
    
    
    static func == (lhs: Work, rhs: Work) -> Bool {
        return true
    }
    
    enum CodingKeys: String, CodingKey {

        case occupation = "occupation"
        case base = "base"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        occupation = try values.decodeIfPresent(String.self, forKey: .occupation)
        base = try values.decodeIfPresent(String.self, forKey: .base)
    }
}
