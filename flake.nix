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
	gh
        sqls
        ruff
        prettier
        python313
	python313Packages.mariadb
        python313Packages.flask
        python313Packages.flask-sqlalchemy
        typescript-language-server
        vscode-langservers-extracted
      ];

      shellHook = ''
        echo "MySQL..."
      '';
    };
  };
}
