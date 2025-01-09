//
//  LocationsView.swift
//  MappingEurope
//
//  Created by Jack Zheng on 9/1/2025.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion)
                .ignoresSafeArea()
            
            VStack {
                header
                
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

// extending on the struct elsewhere
extension LocationsView {
    
    // creating new header subview
    private var header: some View {
        VStack {
            Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            // why maxWidth: .infinity??? and not minWidth???
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .overlay(alignment: .leading) {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            vm.toggleLocationsList()
                        }
                    }, label: {
                        Image(systemName: "arrow.down")
                            .foregroundColor(.primary)
                            .padding(.all, 8)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .rotationEffect(Angle(degrees:vm.showLocationsList ? 180 : 0))
                    })
                    .padding(.horizontal, 10)
                }
               
            if vm.showLocationsList {
                LocationsListView()
            }
            
        }
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        .cornerRadius(10)
        .padding()
        
    }
    
}
