//
//  LocationsListView.swift
//  MappingEurope
//
//  Created by Jack Zheng on 9/1/2025.
//

import SwiftUI

struct LocationsListView: View {
    
    // import our view model every time so we can use the data
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                listRowView(location: location)
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
    
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}

extension LocationsListView {
    
    // must add some View -> so that XCode knows your passing in a view
    // also needs the location parameter since your looping on 'location in vm.locations'
    func listRowView(location: Location) -> some View {
        HStack {
            // why are we using an if-let statement here with no optionals? and why are we using .first if we're looping on an individual location
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            
                VStack (alignment: .leading) {
                    Text(location.name)
                        .font(.headline)
                    Text(location.cityName)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
}
