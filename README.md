# Tic Tac Toe AI

A basilar Flutter mobile TicTacToe game, with both two-player & single-player (A.I.) mode.

## Description

The application is developed following the Material Design guidelines. (Further details are present in the code's comments)

How to:
- Restart the game: Click the reload button on the top-left
- Play in single player (VS the AI): Toggle the "AI" switch button on the top-right

AI:
- The A.I. is designed and developed in order to be able to stop the player's moves quite cleverly. It can prevent every situation, except a double-cross play.

Detailed Preview:
- The App is designed to garantuee a great UX combined with a satisfying UI. If playing with the AI Switch off, two players are needed; therefore, if the AI Switch is on, the match it's against the AI itself.
The User Interface is very simple and intuitive, realised in order to be coherent with the Flutter's Material Design style.
In this interface, every color or graphical detail is assigned and updated dynamically by the relative methods.
The AI has multiple private methods that are used to pursue the goal of winning the match basing the moves on the player's ones. Some of them are not actually used in the current version and they're present if some AI's updates are needed.
The AI real strategy it's not to directly trying to win, but to prevent the human player from winning the game. Any type of basilar attempt of victory is immediately stopped by the AI.
The values of the title and of the graphical matrix are stored in a different TextController each, and every value is stored in an array: when three symbols are indentical, they're changed in from "X" or "O" in "v", so that it is well known which are the cells to highlight to show who (and where) won.

## Getting Started

## Installing and running

The app is currently available on the [Google Play Store](https://play.google.com/store/apps/details?id=com.dipasquale_alessandro.flutter_codify)
but you can compile it by yourself on iOS too, following this [Guide iOS](https://docs.flutter.dev/deployment/ios).
If you want to compile the app by yourself on Android, consider the following [Guide Android](https://docs.flutter.dev/deployment/android).

## Help
Feel free to open an issue in the relative section.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate.

## Version History

* 0.2
    * Various bug fixes and optimizations
    * See [commit change](https://github.com/aledipa/TicTacToeAI/commits/main) or See [release history](https://github.com/aledipa/TicTacToeAI/releases)
* 0.1
    * Initial Release

## License

This project is licensed under the GNU/GPL3 License - see the LICENSE.md file for details


### Detailed (Technical) Documentation's path

[doc/api/index.html](doc/api/index.html)


### Credits

Developer's accounts:
- [GitHub - AleDipa](https://github.com/aledipa)
- [GitLab - AleDipa](https://gitlab.com/AleDipa)

