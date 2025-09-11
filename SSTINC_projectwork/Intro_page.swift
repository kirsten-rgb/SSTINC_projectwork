//
//  Intro_page.swift
//  SSTINC_projectwork
//
//  Created by Kirsten Petros on 1/9/25.
//

import SwiftUI

struct Intro_page: View {
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Welcome to Inctropalis")
                    .font(.largeTitle)
                    .font(.custom("American Typewriter", size: 50))
                    .foregroundStyle(.green)
                
                Text("The Inc bank has just called in with a case!")
               
                NavigationLink {
                    
                    whereHeist()
                    
                } label: {
                    
                    Text("💀 Click Here 💀")
                    
                        .font(.title)
                    
                        .fontWeight(.bold)
                    
                        .foregroundColor(.white)
                    
                        .padding()
                    
                        .frame(width: 200, height: 60)
                    
                        .background(Color.orange)
                    
                        .cornerRadius(12)
                    
                }
                    
            
            }
        }
    }
}
#Preview {
    Intro_page()
}
