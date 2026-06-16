import Foundation

struct Match: Identifiable, Hashable {
    let id = UUID()
    let homeTeam: String
    let awayTeam: String
    let group: String
    let venue: String
    let city: String
    let fixtureDate: Date
}

extension Match {
    static let worldCup2026: [Match] = [
        Match(
            homeTeam: "France",
            awayTeam: "Senegal",
            group: "Group I",
            venue: "New York New Jersey Stadium",
            city: "East Rutherford, NJ",
            fixtureDate: Date.worldCupFixture(year: 2026, month: 6, day: 16)
        ),
        Match(
            homeTeam: "Iraq",
            awayTeam: "Norway",
            group: "Group I",
            venue: "Boston Stadium",
            city: "Foxborough, MA",
            fixtureDate: Date.worldCupFixture(year: 2026, month: 6, day: 16)
        ),
        Match(
            homeTeam: "Argentina",
            awayTeam: "Algeria",
            group: "Group J",
            venue: "Kansas City Stadium",
            city: "Kansas City, MO",
            fixtureDate: Date.worldCupFixture(year: 2026, month: 6, day: 16)
        ),
        Match(
            homeTeam: "Austria",
            awayTeam: "Jordan",
            group: "Group J",
            venue: "San Francisco Bay Area Stadium",
            city: "Santa Clara, CA",
            fixtureDate: Date.worldCupFixture(year: 2026, month: 6, day: 16)
        )
    ]
}

extension Date {
    static func worldCupFixture(year: Int, month: Int, day: Int) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current

        return calendar.date(
            from: DateComponents(
                timeZone: calendar.timeZone,
                year: year,
                month: month,
                day: day,
                hour: 12
            )
        ) ?? Date()
    }
}
