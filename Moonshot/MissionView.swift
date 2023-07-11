//
//  MissionView.swift
//  Moonshot
//
//  Created by Radu Petrisel on 11.07.2023.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    VStack(alignment: .leading) {
                        Separator()
                        
                        Text("Mission highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                            .padding(.bottom, 5)
                        
                        Text("Launch date: \(mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "Didn't launch")")
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 5)
                        
                        Separator()
            
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    CrewView(crew: crew)
                }
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map {
            if let astronaut = astronauts[$0.name] {
                return CrewMember(role: $0.role, astronaut: astronaut)
            }
            
            fatalError("Cannot find astronaut \($0.name).")
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
        
        MissionView(mission: missions[3], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
