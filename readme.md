# CPP tutorial examples, with a nix flake, and sprinkles of minimalism.

This flake contains three distinct features.
 - a devshell, so with `` nix develop `` you can compile C++ by hand!
 - runnable lesson app examples, such that `` nix run .#LessonOne `` will start gdb on lesson one.
 - buildable derivations for each lesson such that ``  nix build .#LessonOne `` will provide the final executable in the nix store.

 ## Lessons and concepts.
  - LessonOne - Basic debugger invocation and usage
  - LessonTwo - Horrible broken code.

# do the lesson run, without doing the gitclone?
Flakes are awesome, so awesome that you can ```  nix run github:darthpjb/cppTutorials#LessonOne ``` without ever cloning this repo - and still be debugging the source code, crazy huh?