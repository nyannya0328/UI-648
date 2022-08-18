//
//  ContentView.swift
//  UI-648
//
//  Created by nyannyan0328 on 2022/08/18.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model : LockScreenViewModel = .init()
    var body: some View {
      Home()
            .gesture(
            
                MagnificationGesture().onChanged({ value in
                    
                    model.sclae = value + model.lastScale
                    
                })
                .onEnded({ _ in
                    
                    if model.sclae < 1 && model.sclae > 1{
                        withAnimation(.easeInOut(duration: 0.15)){
                            
                            model.sclae = 1
                        }
                        
                    }
                    
                    model.lastScale = model.sclae - 1
                    
                })
            )
            .ignoresSafeArea()
            .environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
