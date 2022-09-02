{
  inputs =
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
  let
     pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in
  {
   # Fast preview for current configuration
    apps."x86_64-linux".LessonOne =
    let
      preview_script = pkgs.writeShellApplication
      {
        name = "DebugLessonOne";
        runtimeInputs =
        [
          pkgs.gcc
          pkgs.gdb
          pkgs.figlet
        ];
        text = ''
          figlet "building sources"
          # This builds sources with maximum warnings, debug-symbols, and zero optimsation - good for debugging
          g++ -Wall -Werror -ansi -pedantic-errors -O0 -g ./src/LessonOne.cpp -o ./build/LessonOne.o -c

          figlet "Linking object files"
          g++ -o ./build/LessonOne-exe ./build/LessonOne.o

          figlet "invoking Debugger"
          gdb ./build/LessonOne-exe
        '';
      };
    in
    {
      type = "app";
      program = "${preview_script}/bin/${preview_script.name}";
    };

    # devshell for quick development
    devShell."x86_64-linux" = pkgs.mkShell
    {
      buildInputs =
      [
        pkgs.gcc
        pkgs.gdb
        # figlet for attractive messages
        pkgs.figlet
      ];

    shellHook = ''
        figlet "Shell Active:"
    '';
    };

    # generate final output stl files
    packages."x86_64-linux".LessonOne = pkgs.stdenv.mkDerivation
    {
      name = "cppTutorials";
      src = self;
      buildInputs =
      [
        pkgs.gcc
        pkgs.gdb
      ];
      dontInstall = true;
      dontPatch = true;
      buildPhase = ''
        # Build output in a single step, with maximum optimsation, no debugging symbols - AND ALL THE WARNINGS
        g++ -Wall -Werror -ansi -pedantic-errors -O3 ./src/LessonOne.cpp -o ./build/LessonOne
        mkdir -p $out
        mkdir -p $out/bin
        mv build/LessonOne $out/bin/
      '';
    };

    defaultPackage."x86_64-linux" = self.packages."x86_64-linux".cppTutorials;
  };
}
