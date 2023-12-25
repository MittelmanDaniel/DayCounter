//
//  ContentView.swift
//  DayCounter
//
//  Created by Daniel Mittelman on 12/24/23.
//

import SwiftUI

struct ContentView: View {
    @State private var count: Int = UserDefaults.standard.integer(forKey: "dailyCount")
    @State private var lastUpdatedDate: Date? = UserDefaults.standard.object(forKey: "lastDate") as? Date
    
    var body: some View {
        VStack {
            Text("Count: \(count)")
                .font(.largeTitle)
            
            Button(action: {
                incrementCountIfNeeded()
            }) {
                Text("Increment")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onAppear {
            incrementCountIfNeeded()
        }
    }
    
    func incrementCountIfNeeded() {
        if let lastDate = lastUpdatedDate {
            if !Calendar.current.isDateInToday(lastDate) {
                count += 1
                UserDefaults.standard.set(count, forKey: "dailyCount")
                UserDefaults.standard.set(Date(), forKey: "lastDate")
                lastUpdatedDate = Date()
            }
        } else {
            UserDefaults.standard.set(count, forKey: "dailyCount")
            UserDefaults.standard.set(Date(), forKey: "lastDate")
            lastUpdatedDate = Date()
        }
    }
}

@main
struct CounterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
