{
  description = "Deepin Dark X11 Cursor Theme";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        themeName = "DeepinDarkV20-x11";
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "deepin-dark-xcursor";
          version = "1.0.0";
          src = ./.;

          sourceRoot = ".";

          installPhase = ''
            # Create the cursor theme directory
            mkdir -p $out/share/icons/${themeName}
            
            # Copy the cursors directory and index.theme
            if [ -d "$src/cursors" ]; then
              cp -r $src/cursors $out/share/icons/${themeName}/
            fi
            
            # Copy or create the index.theme
            if [ -f "$src/index.theme" ]; then
              cp $src/index.theme $out/share/icons/${themeName}/
            else
              cat > $out/share/icons/${themeName}/index.theme << EOF
[Icon Theme]
Name=${themeName}
Comment=Deepin Dark X11 Cursor Theme
EOF
            fi
          '';

          meta = {
            description = "Deepin Dark X11 cursor theme";
            homepage = "https://github.com/y0usaf/Deepin-Dark-xcursor";
            license = pkgs.lib.licenses.mit;
          };
        };
      }
    );
}