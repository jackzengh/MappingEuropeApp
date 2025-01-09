//
//  LocationPreviewView.swift
//  MappingEurope
//
//  Created by Jack Zheng on 9/1/2025.
//

import SwiftUI

struct LocationPreviewView: View {
    
    // you now must pass a location parameter when you call LocationPreviewView
    let location: Location
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        
        HStack (alignment: .bottom) {
            VStack (alignment: .leading, spacing: 16) {
                imageSection
                headerSection
            }
            VStack (spacing: 10) {
                learnMoreButton
                nextPlaceButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.ultraThinMaterial)
                .offset(y: 50)
                .cornerRadius(25)
        )
        .padding()
        
        
        
        
    }
}

#Preview {
    // ??? Dont fully undersand this and why you can't use vm.locations.first!
    ZStack {
        Color.green.ignoresSafeArea()
        LocationPreviewView(location: LocationsDataService.locations.first!)
            
    }
    .environmentObject(LocationsViewModel())
}

extension LocationPreviewView {
    
    var imageSection: some View {
        ZStack{
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 135, height: 125)
                    .cornerRadius(25)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(25)
    }
    
    var headerSection: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(location.name)
                .font(.title)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.title2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var learnMoreButton: some View {
        Button {
            
        } label: {
        Text("Learn more")
                .font(.headline)
                .frame(width: 125)
                .padding(.vertical, 5)
        }
        .buttonStyle(.borderedProminent)
    }
    
    var nextPlaceButton: some View {
        Button {
            vm.nextPlaceButtonPressed()
        } label: {
        Text("Next place")
                .font(.headline)
                .frame(width: 125)
                .padding(.vertical, 5)
        }
        .buttonStyle(.bordered)
    }
    
}
