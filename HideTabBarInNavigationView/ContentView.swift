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
        NavigationView{
            TabView(selection: $tabSelection){
//                NavigationView{ //if you write the NavigationView here, you cannot remove TabBar after navigation
                    NavigationLink(destination: NavigatedView()){
                        VStack{
                            Text("Here is Tab 1")
                            Text("Tap me to NavigatedView")
                        }
//                        .navigationBarTitle("Tab1")//NavigationBarTitle does not work here
                    }
//                }
                    .tabItem { Text("Tab 1") }
                .tag(Tabs.tab1)
                
//                NavigationView{//Tab2 also has a NavigationView
                    NavigationLink(destination: NavigatedView()){
                        VStack{
                            Text("Here is Tab 2")
                            Text("Tap me to NavigatedView")
                        }
//                        .navigationBarTitle("Tab2")//NavigationBarTitle does not work here
                    }
//                }
                    .tabItem { Text("Tab 2") }
                .tag(Tabs.tab2)
            }
            .navigationBarTitle(returnNaviBarTitle(tabSelection: self.tabSelection))
        }
    }
    
    enum Tabs{
        case tab1, tab2
    }
    
    func returnNaviBarTitle(tabSelection: Tabs) -> String{
        switch tabSelection{
            case .tab1: return "Tab1"
            case .tab2: return "Tab2"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
