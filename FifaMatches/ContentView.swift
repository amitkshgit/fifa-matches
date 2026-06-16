import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date.now

    private let matches = Match.worldCup2026

    private var todaysMatches: [Match] {
        matches
            .filter { Calendar.current.isDate($0.fixtureDate, inSameDayAs: selectedDate) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.03, green: 0.08, blue: 0.12),
                        Color(red: 0.06, green: 0.19, blue: 0.15),
                        Color(red: 0.50, green: 0.08, blue: 0.16)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        header
                        dateControls

                        if todaysMatches.isEmpty {
                            emptyState
                        } else {
                            VStack(spacing: 12) {
                                ForEach(todaysMatches) { match in
                                    MatchRow(match: match)
                                }
                            }
                        }
                    }
                    .padding(20)
                }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("FIFA World Cup 2026")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.72))

            Text("Today's Matches")
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(.white)

            Text(selectedDate.formatted(.dateTime.weekday(.wide).month(.wide).day().year()))
                .font(.headline)
                .foregroundStyle(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 12)
    }

    private var dateControls: some View {
        HStack(spacing: 12) {
            Button {
                selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
            } label: {
                Image(systemName: "chevron.left")
                    .font(.headline)
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.borderedProminent)
            .tint(.white.opacity(0.16))

            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
                .tint(.white)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))

            Button {
                selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
            } label: {
                Image(systemName: "chevron.right")
                    .font(.headline)
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.borderedProminent)
            .tint(.white.opacity(0.16))
        }
        .foregroundStyle(.white)
    }

    private var emptyState: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 34, weight: .semibold))
                .foregroundStyle(.white.opacity(0.85))

            Text("No fixtures saved for this date.")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)

            Text("The starter app includes the June 16, 2026 FIFA World Cup fixtures. Add more dates in Match.swift.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.72))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct MatchRow: View {
    let match: Match

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .center) {
                teamName(match.homeTeam)

                Text("vs")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white.opacity(0.58))
                    .frame(width: 36)

                teamName(match.awayTeam)
            }

            Divider()
                .overlay(.white.opacity(0.22))

            VStack(alignment: .leading, spacing: 8) {
                Label("Kickoff time: check official schedule", systemImage: "clock")
                Label(match.group, systemImage: "trophy")
                Label("\(match.venue), \(match.city)", systemImage: "mappin.and.ellipse")
            }
            .font(.subheadline.weight(.medium))
            .foregroundStyle(.white.opacity(0.78))
        }
        .padding(16)
        .background(.white.opacity(0.14), in: RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.14), lineWidth: 1)
        }
    }

    private func teamName(_ name: String) -> some View {
        Text(name)
            .font(.title3.weight(.bold))
            .foregroundStyle(.white)
            .lineLimit(2)
            .minimumScaleFactor(0.78)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
