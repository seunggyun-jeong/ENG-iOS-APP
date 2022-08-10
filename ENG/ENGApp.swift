//
//  ENGApp.swift
//  ENG
//
//  Created by 정승균 on 2022/08/09.
//

import SwiftUI

@main
struct ENGApp: App {
    var body: some Scene {
        WindowGroup {
            
            // main에서 TabView로 묶어서 표현
            TabView {
                NavigationView {
                    FacilityView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "building")
                        .foregroundColor(Color.theme.sub)
                    Text("시설")
                }
                NavigationView {
                    Text("마이페이지")
                }
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color.theme.sub)
                    Text("마이페이지")
                }
            }
            
        }
    }
}
