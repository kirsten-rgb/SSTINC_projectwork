//
//  ContentView.swift
//  SSTINC_projectwork
//
//  Created by Kirsten Petros on 1/9/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {   // Put everything inside NavigationStack
            
            ZStack {
                
                Color.black
                
                    .ignoresSafeArea() // full black background
                
                
                
                VStack {
                    
                    Text("INCOIN HEIST")
                    
                        
                    
                        .fontWeight(.bold)
                    
                        .foregroundStyle(.green)
                    
                        .padding(.top, 40)
                        .font(.custom("american typewriter", size: 50))
                    
                    
                    
                    Text("ARE YOU READY TO BEGIN THE INVESTIGATION?")
                    
                        .foregroundStyle(.red)
                    
                    
                        .fontWeight(.bold)
                    
                        .padding(.top, 20)
                    
                        .font(.custom("menlo", size: 30))
                    
                    
                    Spacer()
                    
                    
                    
                    NavigationLink {
                        
                        Intro_page()
                        
                    } label: {
                        
                        Text("Click for instructions")
                        
                            .font(.title)
                        
                            .fontWeight(.bold)
                        
                            .foregroundColor(.white)
                        
                            .padding()
                        
                            .frame(width: 200, height: 60)
                        
                            .background(Color.orange)
                        
                            .cornerRadius(12)
                        
                    }
                    .padding()
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
