//
//  ContentView.swift
//  Moonshot
//
//  Created by Radu Petrisel on 11.07.2023.
//

import SwiftUI

struct ContentView: View {
    private let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    private let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    private let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var viewMode = ViewMode.list
    
    var body: some View {
        NavigationView {
            ScrollView {
                switch viewMode {
                case .grid:
                    LazyVGrid(columns: columns) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                MissionCard(mission: mission)
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                case .list:
                    LazyVStack {
                        ForEach(missions, id: \.id) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                MissionCard(mission: mission)
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    viewMode.toggle()
                } label: {
                    Image(systemName: viewMode.icon)
                }
            }
        }
    }
    
    private enum ViewMode {
        case grid, list
        
        var icon: String {
            switch self {
            case .grid:
                return "list.bullet"
            case .list:
                return "square.grid.2x2"
            }
        }
        
        mutating func toggle() {
            switch self {
            case .grid:
                self = .list
            case .list:
                self = .grid
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
