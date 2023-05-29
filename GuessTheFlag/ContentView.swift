//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Eduardo Hoffmann on 12/05/23.
//

import SwiftUI

struct ContentView: View {
    
   
    @State private var endGameAlert = false
    @State private var currentRound = 0
    @State private var maxRound = 7
    @State private var showingAlert = false
    @State private var minimo = 8
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var cont: Int = 0
    @State private var contError: Int = 0
    
    @State private var x: String = ""
    @State private var y: Int = 0
    
    var body: some View {
        
        ZStack {
            /*LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)*/
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Text("Adivinhe a bandeira")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Toque na bandeira da:")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.white)
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        Text("Pontuação:")
                            .foregroundColor(.blue)
                        Text("Acertos: \(cont)        Erros: \(contError)")
                            .font(.custom(
                                "AmericanTypewriter",
                                fixedSize: 23))
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                    }
                    
                    //.foregroundColor(.white)
                    .foregroundStyle(.secondary)
                    .font(.title.bold())
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    ForEach (0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                            //.shadow(radius: 5)
                                .shadow(color: .black, radius: 2)
                                
                        }
                        
                    }
                    
                        if minimo == 8 {
                            Text("Você tem \(minimo) jogadas")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                        } else if minimo > 1 && minimo < 8  {
                            Text("Você ainda tem \(minimo) jogadas")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        } else {
                            Text("Esta é sua última jogada")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        
                    
                }
                .padding()
            }
            .alert(isPresented: $showingScore) {
                        if endGameAlert {
                            return Alert(title: Text("Fim do jogo!"),
                                  message:Text("Seu resultado foi: \(cont) acertos!"),
                                         dismissButton: .destructive(Text("Jogar novamente")){
                                   self.resetGame() // reset game here
                                })
                        } else {
                           
                            return Alert(title: Text(scoreTitle),
                                  message:Text(x),
                                  dismissButton: .default(Text("Continuar")){
                                    self.askQuestion()
                                })
                            
                        }
                    }
            
           /* // valendo
            .alert(isPresented:$showingScore) {
                Alert(
                    title: Text(scoreTitle),
                    message: Text(x),
                    dismissButton: .default(Text("Continuar"), action: askQuestion))}
            //fim valendo */
            
            /*  primaryButton:
             .destructive(Text("Continuar"), action: askQuestion), secondaryButton: .cancel())}*/
            
            /*.alert(scoreTitle, isPresented: $showingScore) {
             Button("Continuar", action: askQuestion)
             } message: {
             Text("Esta é a bandeira da: \(countries[x])")
             
             }*/
            
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correta!"
            cont += 1
            x = "Parabéns!"
        } else {
            scoreTitle = "Errada!"
            contError += 1
            x = "Esta é a bandeira da \(self.countries[number])"
        }
       
        showingScore = true
        
        endGameAlert = currentRound == maxRound
            // score = 0        // reset this at the "Restart" call
            // currentRound = 0 // reset this at the "Restart" call
            
            if currentRound < maxRound {
                currentRound += 1
               // minimo -= 1
            }
            showingAlert = true
        
    }
    
    func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        minimo -= 1
    
        }
    
    func resetGame() {
        cont = 0
        contError = 0
        currentRound = 0
        minimo = 8
    }
      
    }
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
