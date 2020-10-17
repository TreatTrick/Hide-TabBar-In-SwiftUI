# How to Hide TabBar in NavigationView When Using SwiftUI
Recently, more and more people are using `SwiftUI` to develop iOS apps, but as a new tool `SwiftUI` still has a lot of unresolved problems.  

Lots of developers found that they cannot hide `TabBar` when they use `NavigationView` to navigate to a new view in `SwiftUI`. It is pretty annoying.  

Here, I would like to give you guys a solution to solve this problem. I will explain some `View` knowledge first to help you guys understand what's actually going on in in `swiftUI`.

## The Hierarchy of SwiftUI Views
Here is a demo app. In this demo, I have two tabs, *tab1* and *tab2* in a `TabView`, and I want to tap the text in each *tab* to navigate to `NavigatedView`. So, I add `NavigationView` and `NavigationLink` to the contents in each *tab*. The code is as the below.

### ContentView.swift

```swift
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
            
            NavigationView{//Tab2 also has a NavigationView
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
```
### NavigatedView.swift


```swift
import SwiftUI

struct NavigatedView: View {
    var body: some View {
        Text("Hi! This is the NavigatedView")
            .navigationBarTitle("NavigatedView")
    }
}
```


When running the code:
![Navigation in TabView](/Pictures/gif1.gif)

