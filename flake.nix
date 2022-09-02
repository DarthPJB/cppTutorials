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
          g++ -Wall -Werror -ansi -pedantic-errors -g ./src/LessonOne.cpp -o ./build/LessonOne.o -c

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
    packages."x86_64-linux".cppTutorials = pkgs.stdenv.mkDerivation
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
        
        mkdir -p $out
        mv output/ $out/
      '';
    };

    defaultPackage."x86_64-linux" = self.packages."x86_64-linux".cppTutorials;
  };
}
