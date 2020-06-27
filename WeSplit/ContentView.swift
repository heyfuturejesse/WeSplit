//
//  ContentView.swift
//  WeSplit
//
//  Created by Jesse Russell on 19/6/20.
//  Copyright © 2020 Jesse Russell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalPlusTip: Double {
        let netTotal = Double(totalPerPerson)
        let numOfPeople = Double(numberOfPeople) ?? 1
        
        let tipTimesPeople = netTotal * numOfPeople
        
        return tipTimesPeople
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Check Amount")) {
                    TextField("$0.00", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Number of people")) {
                    TextField("0", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                                
                Section(header: Text("How much of a tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Check total(Including Tip)")) {
                    Text("$\(totalPlusTip, specifier: "%.2f")")
                        .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .blue)
                }
                
                Section(header: Text("Total Per Person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
