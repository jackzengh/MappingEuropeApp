//
//  LocationAnnotationView.swift
//  MappingEurope
//
//  Created by Jack Zheng on 9/1/2025.
//

import SwiftUI

struct LocationAnnotationView: View {
    var body: some View {
        
        VStack {
            Image(systemName: "binoculars.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .padding(.all, 5)
                .background(Color.accentColor)
                .clipShape(
                    Circle()
                )
            Image(systemName: "triangle.fill")
                .foregroundColor(.accentColor)
                .rotationEffect(.degrees(180))
                .offset(x: 0, y: -5)
                .padding(.bottom, 40)
        }
        
    }
}

#Preview {
    ZStack {
        
        Color.black.ignoresSafeArea()
        
        LocationAnnotationView()
        
    }
    
}
