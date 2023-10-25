//
//  Joke.swift
//  apiNetworking
//
//  Created by Егор on 23.10.2023.
//

import Foundation

// https://v2.jokeapi.dev/joke/
// Programming,Miscellaneous,Dark,Pun,Spooky,Christmas?
// blacklistFlags=nsfw,religious,political,racist,sexist,explicit&
// type=twopart

enum JokesTheme: String {
    case programming = "Programming"
    case misc = "Miscellaneous"
    case dark = "Dark"
    case pun = "Pun"
    case spooky = "Spooky"
    case xmas = "Christmas"
}

enum JokesBlackFlags: String {
    case nsfw = "nsfw"
    case religious = "religious"
    case political = "political"
    case racist = "racist"
    case sexist = "sexist"
    case explicit = "explicit"
}

struct JokeArr: Codable {
    let error: Bool?
    let amount: Int
    let jokes: Jokes
}

// MARK: - Joke
struct Joke: Codable {
    let error: Bool?
    let category, type, setup, delivery: String?
    let flags: Flags?
    let id: Int?
    let safe: Bool?
    let lang: String?
}

// MARK: - Flags
struct Flags: Codable {
    let nsfw, religious, political, racist: Bool?
    let sexist, explicit: Bool?
}

typealias Jokes = [Joke]
