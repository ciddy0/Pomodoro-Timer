//
//  ContentView.swift
//  Pomodoro App
//
//  Created by Cid on 1/1/24.
//  Timer app to effectively study with a zen ui inspiration

import SwiftUI
import Observation
struct checkToggleStyle: ToggleStyle{
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "moon.zzz" : "sun.min")
                    .foregroundStyle(configuration.isOn ? Color.black : Color.white)
                    .accessibility(label: Text(configuration.isOn ? "dark" : "light"))
                    .imageScale(.large)
                    .frame(width: 50, height: 44)
            }
        }.buttonStyle(.plain)
    }
}
struct ContentView: View {
    @State var countDownTimer = 300
    @State var prevTimer = 300
    @State var timerRunning = false
    @State var darkMode = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack{
                Text("Pomodoro Timer")
                    .bold()
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .monospaced()
                    .shadow(color: darkMode ?  .gray : .gray, radius: 4)
                    .shadow(color: darkMode ? .black : .white, radius:5)
                    .padding()
                    .padding()
            }
            Circle()
                .stroke(darkMode ? Color.white : Color.black, lineWidth: 10)
                .frame(width:100, height: 100)
            ZStack{
                Circle()
                    .stroke(Color.white, lineWidth: 10)
                    .frame(width:100, height: 100)
                    .shadow(color:darkMode ? .black:.white, radius: 15)
                Circle()
                    .stroke(Color.gray, lineWidth: 100)
                    .frame(width:1, height: 1)
                Text(displayTime(secs:countDownTimer))
                    .onReceive(timer, perform: { _ in
                        if countDownTimer > 0 && timerRunning {
                            countDownTimer -= 1
                        }else {
                            timerRunning = false
                        }
                    }).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white).monospaced()
                    .shadow(color: .gray, radius: 4)
                    .shadow(color: .black, radius:5)
            }
            .padding().padding()
            Circle()
                .stroke(darkMode ? Color.white : Color.black, lineWidth: 10)
                .frame(width:50, height: 50)
            
            HStack{
                Button("Start"){
                    timerRunning = true
                }.padding().bold()
                    .foregroundStyle(.white).monospaced()
                    .shadow(color: darkMode ? .gray : .white, radius: 4)
                    .shadow(color: darkMode ? .black : .white, radius:5)
                Button("Reset"){
                    countDownTimer = prevTimer
                    timerRunning = false
                }.padding().bold()
                    .foregroundStyle(.white).monospaced()
                    .shadow(color: darkMode ? .gray : .white, radius: 4)
                    .shadow(color: darkMode ? .black : .white, radius:5)
            
            }.padding()
            HStack{
                Button("5:00"){
                    prevTimer = 300
                    countDownTimer = 300
                }
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(8)
                .padding()
                .shadow(color: darkMode ? .black:.white, radius: 10)
                .monospaced()
                .bold()
                
                Button("15:00"){
                    prevTimer = 900
                    countDownTimer = 900
                }
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(8)
                .padding()
                .shadow(color: darkMode ? .black:.white, radius: 10)
                .monospaced()
                .bold()
                Button("25:00"){
                    prevTimer = 1500
                    countDownTimer = 1500
                }
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(8)
                .padding()
                .shadow(color: darkMode ? .black:.white, radius: 10)
                .monospaced()
                .bold()
                
            }.buttonStyle(.bordered).padding()
            Spacer()
            HStack{
                
                Toggle(isOn: $darkMode){
                    
                }.toggleStyle(checkToggleStyle()).padding(.horizontal).padding(20).bold()
                    .shadow(color: darkMode ? .gray : .white, radius: 4)
                Spacer()
                
            }
            
        }.background(darkMode ? Color.white : Color.black)
        
            
        }
    
    func displayTime(secs:Int) -> String{
        var minutes = countDownTimer / 60
        var seconds = countDownTimer % 60
        if seconds > 9 {
            return "\(minutes):\(seconds)"
        }else{
            return "\(minutes):0\(seconds)"
        }
        
    }
        
}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
        
    }
    
}
