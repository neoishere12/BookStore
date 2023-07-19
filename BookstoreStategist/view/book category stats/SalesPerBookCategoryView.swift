//
//  SalesPerBookCategoryView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 17.07.23.
//

import SwiftUI

struct SalesPerBookCategoryView: View {
    
    enum ChartStyle: String, CaseIterable, Identifiable {
        case pie = "Pie Chart"
        case bar = "Bar Chart"
        case singleBar = "Single Bar"
      
        var id: Self { self }
    }
    
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var selectedChartStyle: ChartStyle = .pie
    
    var body: some View {
        VStack {
            Picker("Chart Type", selection: $selectedChartStyle) {
                ForEach(ChartStyle.allCases) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
           
  
            SalesPerBookCategoryHeaderView(selectedChartStyle: selectedChartStyle,
                                           salesViewModel: salesViewModel)
            .font(.title3).padding(.vertical)
            
            switch selectedChartStyle {
                case .bar:
                    SalesPerBookCategoryBarChartView(salesViewModel: salesViewModel)
                case .pie:
                    SalesPerBookCategoryPieChartView(salesViewModel: salesViewModel)
                case .singleBar:
                    SalesPerBookCategoryStackedBarChartView(salesViewModel: salesViewModel)
            }
            
           
           Spacer()
          //  SalesPerBookCategoryListView(salesViewModel: salesViewModel)
        } .padding()
    }
}

#Preview {
    SalesPerBookCategoryView(salesViewModel: .preview)
}