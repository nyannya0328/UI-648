//
//  Home.swift
//  UI-648
//
//  Created by nyannyan0328 on 2022/08/18.
//

import SwiftUI
import PhotosUI

struct Home: View {
    @EnvironmentObject var model : LockScreenViewModel
    var body: some View {
        VStack{
            
            
            if let compressedImage = model.comepressedImage{
                
                
                GeometryReader{proxy in
                
                     let size = proxy.size
                    
                    Image(uiImage: compressedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width,height: size.height)
                        .scaleEffect(model.sclae)
                        .overlay {
                            TimeView()
                        }
                    
                    
                    
                }
                
                
            }
            else{
               
                PhotosPicker(selection: $model.pickedItem,matching: .images,preferredItemEncoding: .automatic,photoLibrary:.shared()) {
                    
                    VStack(spacing:15){
                        
                        Image(systemName: "plus.viewfinder")
                           .font(.system(size: 60))
                           .foregroundColor(.white)
                           .background{
                            
                               RoundedRectangle(cornerRadius: 10,style: .continuous)
                                   .fill(.cyan)
                           }
                       
                       Text("Add Images")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                }
              
            }
            
        }
        .overlay(alignment: .topLeading) {
            
            
            Button("Chancel"){
                
                withAnimation(.interpolatingSpring(stiffness: 250, damping: 30)){
                    
                    model.comepressedImage = nil
                    
                }
                
                
                
            }
            .padding(.vertical,20)
            .padding(.horizontal)
            .font(.caption.weight(.semibold))
            .foregroundColor(.black)
            .background{
             
                Capsule()
                    .fill(.ultraThinMaterial)
            }
            .opacity(model.comepressedImage == nil ? 0 : 1)
            .padding(.top,50)
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TimeView : View{
    
    var body: some View{
        
        
        HStack(spacing:0){
            
            Text(Date.now.convertToString(.hour))
                .font(.system(size: 100))
                .fontWeight(.semibold)
            
            VStack(spacing:10){
                
                Circle()
                .fill(.white)
                 .frame(width: 15,height: 15)
                
                Circle()
                .fill(.white)
                 .frame(width: 15,height: 15)
            }
            
            
            Text(Date.now.convertToString(.minute))
                .font(.system(size: 100))
                .fontWeight(.semibold)
            
            VStack(spacing:10){
                
                Circle()
                .fill(.white)
                 .frame(width: 15,height: 15)
                
                Circle()
                .fill(.white)
                 .frame(width: 15,height: 15)
            }
            
            
            Text(Date.now.convertToString(.second))
                .font(.system(size: 100))
                .fontWeight(.semibold)
            
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .padding(.top,150)
    }
}


enum DataFromat : String{
    
    case hour = "hh"
    case minute = "mm"
    case second = "ss"
}

extension Date{
    
    func convertToString(_ format : DataFromat) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        
        return formatter.string(from: self)
    }
}
