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
                    .foregroundStyle(.green)
                    .font(.custom("american typewriter", size: 50))
                    
            
            }
        }
    }
}
#Preview {
    Intro_page()
}
