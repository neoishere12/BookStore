//
//  SalesListView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 16.07.23.
//

import SwiftUI
import Charts

struct DetailBookSalesView: View {
    
    enum TimeInterval: String, CaseIterable, Identifiable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        var id: Self { self }
    }
    @ObservedObject var salesViewModel: SalesViewModel = .preview
    @State private var selectedTimeInterval = TimeInterval.day
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $selectedTimeInterval.animation()) {
                ForEach(TimeInterval.allCases) { interval in
                    Text(interval.rawValue)
                }
            } label: {
                Text("Time interval")
            }
            .pickerStyle(.segmented)
            
            Group {
                Text("You sold ") +
                Text("\(salesViewModel.totalSales) books").bold().foregroundStyle(Color.accentColor) +
                Text(" in the last 90 days.")
            }.padding(.vertical)
            
            //TODO: make scrollable
            switch selectedTimeInterval {
                case .day:
                    DailySalesChartView(salesData: salesViewModel.salesData)
                case .week:
                    WeeklySalesChartView(salesViewModel: salesViewModel)
                case .month:
                   MonthlySalesChartView(salesViewModel: salesViewModel)
            }
            
            List {
                ForEach(salesViewModel.books) { book in
                    HStack(alignment: .firstTextBaseline) {
                        Text(book.title)
                        Text(book.category.rawValue)
                        Spacer()
                        Text("\(salesViewModel.sales(for: book)) sales")
                    }
                    
                }
            }
        }
        .padding()
    }
}

#Preview {
    DetailBookSalesView(salesViewModel: .preview)
}
