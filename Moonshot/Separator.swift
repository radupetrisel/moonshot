//
//  Separator.swift
//  Moonshot
//
//  Created by Radu Petrisel on 11.07.2023.
//

import SwiftUI

struct Separator: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct Separator_Previews: PreviewProvider {
    static var previews: some View {
        Separator()
    }
}
