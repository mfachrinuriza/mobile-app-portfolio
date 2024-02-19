//
//  Portofolio.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation

public struct ChartData: Codable {
    public var type: String
    public var data: ChartContent
}

public enum ChartContent: Codable {
    case donutChart([DonutChart])
    case lineChart(LineChart)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let donutChart = try? container.decode([DonutChart].self) {
            self = .donutChart(donutChart)
            return
        }
        if let lineChart = try? container.decode(LineChart.self) {
            self = .lineChart(lineChart)
            return
        }
        throw DecodingError.typeMismatch(ChartContent.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ChartContent"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .donutChart(let value):
            try container.encode(value)
        case .lineChart(let value):
            try container.encode(value)
        }
    }
}

public struct DonutChart: Codable {
    public var label: String
    public var percentage: String
    public var data: [Transaction]
}

extension DonutChart: Equatable {
    public static func == (lhs: DonutChart, rhs: DonutChart) -> Bool {
        return lhs.label == rhs.label && lhs.data.count == rhs.data.count
    }
}

public struct Transaction: Codable {
    public var trx_date: String
    public var nominal: Int
}

public struct LineChart: Codable {
    public var month: [Double]
}

extension LineChart: Equatable {
    public static func == (lhs: LineChart, rhs: LineChart) -> Bool {
        return lhs.month == rhs.month
    }
}
