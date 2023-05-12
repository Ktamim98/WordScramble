# Word Scramble Game
This is a simple iOS game built using SwiftUI. The game is a word scramble game where the user has to create new words from a given root word.


## Features
- Users can input words by typing into the text field
- App checks if the word is valid based on the following conditions:
 - The word should be more than three letters long
 - The word should be an original word that has not been used before
 - The word should be possible to form using the given letters of the root word
 - The word should be a real English word
- App uses UITextChecker to check for misspelled words
- App provides an alert message to the user if the word entered is invalid
- Users can see all the valid words they have entered in a list
- Each word in the list shows the number of letters in the word
- App uses accessibility features for better usability



### Code Overview
## ContentView
The main view of the application is defined in ContentView.swift. This view has four important @State properties:

- usedWord - An array of valid words entered by the user
- rootWord - The given root word that users need to form other words from
- newWord - The current word entered by the user in the text field
- showError, errorTitle, errorMessage - Variables used to show alerts when there is an error in the entered word
The body of the ContentView contains a List with two sections: one for entering words and one for displaying the list of valid words. The text field is defined in the first section of the list.

The onSubmit modifier is used to call the addNewWord() function when the user submits the word they have entered.

The onAppear modifier is used to call the startNewGame() function when the view appears.

The toolbar at the top of the view contains a "New Word" button that calls the startNewGame() function when tapped.

## addNewWord()
The addNewWord() function takes the current word entered by the user and checks if it is a valid word using four conditions:

- The word should be more than three letters long
- The word should be an original word that has not been used before
- The word should be possible to form using the given letters of the root word
- The word should be a real English word
If the entered word does not meet any of these conditions, an alert message is shown to the user.

If the entered word meets all four conditions, it is added to the usedWord array using the withAnimation modifier. The text field is then cleared so that the user can enter a new word.

## startNewGame()
The startNewGame() function fetches a start.txt file from the app's resources and chooses a random word from it to use as the root word. If the file cannot be fetched, the function will throw a fatal error.

## Accessibility Features
The app uses accessibility features to make it more user-friendly. Each word in the list is given a label that corresponds to the word, and the number of letters in the word is given as a hint. This makes it easier for users with visual impairments to understand the content of the app.

## Credits
This project was built as part of the "100 Days of SwiftUI" course by Paul Hudson.
