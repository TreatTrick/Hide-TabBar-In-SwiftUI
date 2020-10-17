//
//  ContentView.swift
//  HideTabBarInNavigationView
//
//  Created by SORA on 2020/10/17.
//

import SwiftUI

struct ContentView: View {
    @State var tabSelection: Tabs = .tab1
    var body: some View {
        TabView(selection: $tabSelection){
            NavigationView{ //if you write the NavigationView here, you cannot remove TabBar after navigation
                NavigationLink(destination: NavigatedView()){
                    VStack{
                        Text("Here is Tab 1")
                        Text("Tap me to NavigatedView")
                    }
                    .navigationBarTitle("Tab1")
                }
            }
            .tabItem { Text("Tab 1") }
            .tag(Tabs.tab1)
            
            NavigationView{
                NavigationLink(destination: NavigatedView()){
                    VStack{
                        Text("Here is Tab 2")
                        Text("Tap me to NavigatedView")
                    }
                    .navigationBarTitle("Tab2")
                }
            }
            .tabItem { Text("Tab 2") }
            .tag(Tabs.tab2)
        }
    }
    
    enum Tabs{
        case tab1, tab2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
