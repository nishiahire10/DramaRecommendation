//
//  ContentView.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import SwiftUI

struct ContentView: View {
    init() {
        setupTabBarAppearance()
    }
    var body: some View {
        TabView {
            NavigationStack {
                RecommendationView()
            }
            .tabItem {
                Image(systemName: "heart.rectangle")
                Text("Recommendation")
            }
            NavigationStack{
                ReviewView()
            }
            .tabItem {
                Image(systemName: "rectangle.3.group.bubble.left")
                Text("Reviews")
            }
        }
    }
    
    private func setupTabBarAppearance() {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.systemBackground // or any other color
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
