//
//  DramaCellView.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import SwiftUI

struct DramaCellView: View {
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://i.mydramalist.com/rNxKdm_4t.jpg")) { image in
                image.resizable()
                    .frame(width: 80, height: 80, alignment: .leading)
                    .padding()
            } placeholder: {
                ProgressView()
                    .padding()
            }
            
            Text("Heroes")
                .font(.title2)
            Spacer()
        }
    }
}

struct DramaCellView_Previews: PreviewProvider {
    static var previews: some View {
        DramaCellView()
    }
}
