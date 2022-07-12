//
//  ContentView.swift
//  Shared
//
//  Created by Alex Maggio on 12/07/2022.
//

import SwiftUI

let server = "http://192.168.1.100:81"
//let server = "http://localhost:8000/uploadfile/"

struct ContentView: View {
    @State private var downloadAmount = 0.0
    @State var fileToUpload = ""
    
    var body: some View {
        VStack {
            Button(action: {
                let filePath = FileGenerator().writeDataToFile(file: UUID().uuidString, size: 1.gb) { progress in
                    downloadAmount = progress
                }
                fileToUpload = (filePath.count > 0 ? filePath : "")
                print(fileToUpload)
            }, label: {
                Text("Generate File")
                    .font(.title)
            })
                .disabled(fileToUpload.count > 0)
                .padding()
            
            if downloadAmount > 0, downloadAmount != 1 {
                ProgressView(
                    "Generating File",
                    value: min(downloadAmount, 1),
                    total: 1
                )
            }
            
        
            Button(action: {
                print("Upload File")
                FileUploader().uploadFile(
                    fileName: fileToUpload,
                    to: URL(string: server)!) {
                        success, data in
                        if success, let data = data {
                            print(String(data: data, encoding: .utf8)!)
                        } else {
                            print("No Data")
                        }
                    }
            }, label: {
                VStack {
                    Text("Upload File")
                        .font(.title)
                    if fileToUpload.count > 0 {
                        Text(fileToUpload)
                            .font(.caption)
                    }
                }
            })
                .disabled(fileToUpload.count == 0)
                .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


