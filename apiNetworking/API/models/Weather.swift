//
//  Weather.swift
//  apiNetworking
//
//  Created by Егор on 23.10.2023.
//

import Foundation

// https://api.open-meteo.com/v1/gfs?
// latitude=52.52&longitude=13.41
// &hourly=temperature_2m,rain,visibility,windspeed_10m,winddirection_10m&windspeed_unit=ms
// &timeformat=unixtime&timezone=Europe%2FMoscow&start_date=2023-10-21&end_date=2023-10-27

// MARK: - Weather
struct Weather: Codable {
    let latitude, longitude, generationtimeMS: Double?
    let utcOffsetSeconds: Int?
    let timezone, timezoneAbbreviation: String?
    let elevation: Int?
    let hourlyUnits: HourlyUnits?
    let hourly: Hourly?

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case hourlyUnits = "hourly_units"
        case hourly
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let time: [Int]?
    let temperature2M, rain: [Double]?
    let visibility: [Int]?
    let windspeed10M: [Double]?
    let winddirection10M: [Int]?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case rain, visibility
        case windspeed10M = "windspeed_10m"
        case winddirection10M = "winddirection_10m"
    }
}

// MARK: - HourlyUnits
struct HourlyUnits: Codable {
    let time, temperature2M, rain, visibility: String?
    let windspeed10M, winddirection10M: String?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case rain, visibility
        case windspeed10M = "windspeed_10m"
        case winddirection10M = "winddirection_10m"
    }
}
