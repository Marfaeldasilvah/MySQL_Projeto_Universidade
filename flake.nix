{
  description = "Projeto Galeria BC";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    formatter.${system} = pkgs.alejandra;
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
#git + lsps
	gh
        sqls
        ruff
	vscode-langservers-extracted
	typescript-language-server
        prettier
#python
        python313
	python313Packages.mariadb
        python313Packages.flask
        python313Packages.flask-sqlalchemy

      ];

      shellHook = ''
        echo "MySQL..."
      '';
    };
  };
}
