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
