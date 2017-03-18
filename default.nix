with import <nixpkgs> {}; {

  freestyleEnv = stdenv.mkDerivation rec {
    name = "Kraken-Playpen";

    mycherrypy = pkgs.lib.overrideDerivation python3Packages.cherrypy (attrs: rec {
        version = "3.2.4";
        name = "cherrypy-${version}";
        src = pkgs.fetchurl {
            url = "https://github.com/cherrypy/cherrypy/archive/${version}.tar.gz";
            sha256 = "92358a0678425e42438f095f5d0d5c0fa60c02c62e21cb5872595e8d227a0f84";
        };
    });

    buildInputs = [ python3 python3Packages.bottle python3Packages.pygments mycherrypy ];
  };
}

