{
  description = "Projeto Galeria BC";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
	gh
        sqls
	ruff
	python313
	python313Packages.flask
      ];

      shellHook = ''
        echo "MySQL..."
      '';
    };
  };
}
