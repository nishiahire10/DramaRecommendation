//
//  DramaCellView.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import SwiftUI

struct DramaCellView: View {
    @State var urlstr : String
    @State var titleStr : String
    var body: some View {
        ZStack(alignment: .center) {
            AsyncImage(url: URL(string: urlstr)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(5)
                    .edgesIgnoringSafeArea(.all) // Optional: to cover the entire screen

            } placeholder: {
                ProgressView()
                    .padding()
            }
            VStack{
                Spacer()
                Text(titleStr)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(20)
                    .padding(.bottom, 20) // Space from the bottom edge
                    .padding(.horizontal, 20) // Extra horizontal padding for background
                    .padding(.vertical, 5)
                    .cornerRadius(10) // Rounded corners for text background
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black.opacity(0.8))
                            .padding(10) // Larger background
                    )

            }

        }
    }
}

struct DramaCellView_Previews: PreviewProvider {
    static var previews: some View {
        DramaCellView(urlstr: "https://i.mydramalist.com/jKVgJ_4t.jpg", titleStr: "Youth")
    }
}
