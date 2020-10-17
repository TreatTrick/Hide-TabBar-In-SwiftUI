# How to Hide TabBar in NavigationView When Using SwiftUI
Recently, more and more people are using `SwiftUI` to develop iOS apps, but as a new tool `SwiftUI` still has a lot of unresolved problems.  

Lots of developers find they cannot hide `TabBar` when they use `NavigationView` to navigate to a new view in `SwiftUI`. It is pretty annoying.  

Here, I would like to give you guys a solution to solve this problem. I will explain some `View Hierarchy` knowledge first to help you guys understand what's actually going on in `swiftUI` when we try to use `NavigationView` and `TabView`. You can also directly jump the [solution](#the-solution) if you want to. 

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


When running the code, there is a problem, you can see when I tap the text in `Tab1` and go to the `NavigatedView`, `TabBar` is still at the bottom. However, when we develop an app, sometimes we really want the `TabBar` disappear when navigating.

|Navigation in TabView|before navigation|after navigation|
|---|---|---|
|<img src = "/Pictures/gif1.gif" width = "300" alt = "Navigation in TabView"/>|<img src = "/Pictures/tab1.jpg" width = "300" alt = "Navigation in TabView"/>|<img src = "/Pictures/navi1.jpg" width = "300" alt = "Navigation in TabView"/>|

Why does it run like this? To understand this, let's take a look at `View Hierarchy` in `SwistUI`. When you write the `NavigationView` in `TabView`, the things run in `SwiftUI` like the following pictures.`TabView` contains `NavigationView`, and it makes everything happens in `NavigationView` cannot affect `TabView`, because `NavigationView` is just a subview of `TabView`. So, when navigating to another view, `NavigationView` changes, but as the super-view, `TabView` will stay what it is.

|when the *`Tap Here to a new view`* button is tapped, only the red part, which is `NavigationView` changes to orange part, which is `NavigatedView`, but the blue part, which is the `TabView` stays the same.|
|:---:|
|<img src = "/Pictures/TabNavi.jpg" width = "650" alt = "Navigation in TabView"/>|

Here, it should be clear. If we want to hide the `TabBar`, we just write the `TabView` into `NavigationView`, making the `NavigationView` the super-view and the `TabView` the child-view, which is just opposite to the above `View Hierarchy`.

|when the *`Tap Here to a new view`* button is tapped, the blue part, which is `NavigationView` changes to orange part, which is `NavigatedView`, so the `TabBar` in red part disappear itself.|
|:---:|
|<img src = "/Pictures/NaviTab.jpg" width = "650" alt = "Navigation in TabView"/>|

After knowing this, we just need to modify our code a little to let `NavigationView` contain `TabView`and we can perfectly solve the problem.

## The Solution
Like what has been mentioned above, we just rewrite our code to make the `NavigationView` contains the `TabView`.

```swift
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
                        .navigationBarTitle("Tab1")//NavigationBarTitle does not work here
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
                        .navigationBarTitle("Tab2")//NavigationBarTitle does not work here
                    }
//                }
                    .tabItem { Text("Tab 2") }
                .tag(Tabs.tab2)
            }
        }
    }
    
    enum Tabs{
        case tab1, tab2
    }
}
```
Another problem here is that our `NavigationBarTitle` does not display itself when we write it in `TabView`.

|Navigation in TabView|before navigation|after navigation|
|---|---|---|
|<img src = "/Pictures/gif2.gif" width = "300" alt = "Navigation in TabView"/>|<img src = "/Pictures/solve-tab1.jpg" width = "300" alt = "Navigation in TabView"/>|<img src = "/Pictures/solve-navi1.jpg" width = "300" alt = "Navigation in TabView"/>|

The solution is also easy. Just move the `NavigationBarTitle` to the end of `TabView` and it works fine. But in this way, when we tap different tabs, the `NavigationBarTitle` is always the same, which is not what we want. So, I also added a function `returnNaviBarTitle` to display the right `NavigationBarTitle` based on the selected tab. The following code is the final version.

```swift
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
            .navigationBarTitle(returnNaviBarTitle(tabSelection: self.tabSelection))//add the NavigationBarTitle here.
        }
    }
    
    enum Tabs{
        case tab1, tab2
    }
    
    func returnNaviBarTitle(tabSelection: Tabs) -> String{//this function will return the correct NavigationBarTitle when different tab is selected.
        switch tabSelection{
            case .tab1: return "Tab1"
            case .tab2: return "Tab2"
        }
    }
}
```
|Navigation in TabView|before navigation|after navigation|
|---|---|---|
|<img src = "/Pictures/gif3.gif" width = "300" alt = "Navigation in TabView"/>|<img src = "/Pictures/final-tab1.jpg" width = "300" alt = "Navigation in TabView"/>|<img src = "/Pictures/final-navi1.jpg" width = "300" alt = "Navigation in TabView"/>|

## End
Here ends the doc! Hope you have learned something. Thanks so much for your reading.









