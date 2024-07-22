//
//  ContentView.swift
//  Moonshot
//
//  Created by Vishrut Jha on 7/10/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var isGridView = false

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationView {
            Group {
                if isGridView {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(missions) { mission in
                                NavigationLink(
                                    destination: MissionView(
                                        mission: mission, astronauts: astronauts)
                                ) {
                                    MissionGridItem(mission: mission)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                } else {
                    List(missions) { mission in
                        NavigationLink(
                            destination: MissionView(mission: mission, astronauts: astronauts)
                        ) {
                            MissionListItem(mission: mission)
                        }
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: toggleViewMode) {
                        Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                    }
                }
            }
        }
    }

    private func toggleViewMode() {
        isGridView.toggle()
    }
}

struct MissionGridItem: View {
    let mission: Mission

    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            VStack {
                Text(mission.displayName)
                    .font(.headline)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(Color.lightBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.lightBackground)
        )
    }
}

struct MissionListItem: View {
    let mission: Mission

    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)

            VStack(alignment: .leading) {
                Text(mission.displayName)
                    .font(.headline)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
            }
        }

    }
}

#Preview {
    ContentView()
}
