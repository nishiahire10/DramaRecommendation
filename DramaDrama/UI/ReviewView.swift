//
//  ReviewView.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import SwiftUI

struct ReviewView: View {
    @State private var selectedSegment = 0
    let segments = ["Recent","Best", "Shows", "Movies"]
    var body: some View {
        VStack {
            Picker("Segments", selection: $selectedSegment) {
                ForEach(0..<4) { index in
                    Text(segments[index]).tag(index)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            List {
                ForEach(0..<20) { index in
                   DramaCellView()
                }
            }
            if selectedSegment == 0 {
                
            } else {
                
            }
        }
        .navigationBarTitle("Drama")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
