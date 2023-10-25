//
//  Fruits.swift
//  apiNetworking
//
//  Created by Егор on 23.10.2023.
//

import Foundation

// https://www.fruityvice.com/api/fruit/all
// https://www.fruityvice.com/api/fruit/{ID}
// https://www.fruityvice.com/api/fruit/{name}

// MARK: - FruitElement
struct FruitElement: Codable {
    let name: String?
    let id: Int?
    let family, order, genus: String?
    let nutritions: Nutritions?
}

// MARK: - Nutritions
struct Nutritions: Codable {
    let calories: Int?
    let fat, sugar, carbohydrates, protein: Double?
}

typealias Fruit = [FruitElement]
