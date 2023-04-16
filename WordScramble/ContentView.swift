//
//  ContentView.swift
//  WordScramble
//
//  Created by Tamim Khan on 16/4/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWord = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    
    @State private var errorTitle = ""
    @State private var errorMessege = ""
    @State private var showError = false
    
    
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter your text", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section{
                    ForEach(usedWord, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startNewGame)
            
            .alert(errorTitle, isPresented: $showError){
                Button("ok", role: .cancel){}
            }message: {
                Text(errorMessege)
            }
            .toolbar{
                ToolbarItem{
                    Button(action: startNewGame){
                        Label("New Word", systemImage: "arrow.triangle.2.circlepath")
                    }
                }
            }
        }
        
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespaces)
        
        guard answer.count > 3 else {
            wordError(title: "Oops", messege: "word should more then 3 letters")
            return
        }
        
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", messege: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", messege: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", messege: "You can't just make them up, you know!")
            return
        }
        
        withAnimation{
            usedWord.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    
    func startNewGame(){
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWord = try? String(contentsOf: startWordsUrl){
                let allwords = startWord.components(separatedBy: "\n")
                
                rootWord = allwords.randomElement() ?? "silkWorm"
                
                return
            }
        }
        fatalError("unable to load start.txt")
    }
    
    func isOriginal(word: String) -> Bool{
        !usedWord.contains(word)
    }
    
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspledRange.location == NSNotFound
        
    }
    
    
    func wordError(title: String, messege: String){
        errorTitle = title
        errorMessege = messege
        showError = true
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
