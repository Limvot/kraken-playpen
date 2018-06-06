with import <nixpkgs> {}; {

  freestyleEnv = stdenv.mkDerivation rec {
    name = "Kraken-Playpen";

    #mycherrypy = pkgs.lib.overrideDerivation python3Packages.cherrypy (attrs: rec {
        #version = "3.2.4";
        #name = "cherrypy-${version}";
        #doCheck = false;
        #src = pkgs.fetchurl {
            #url = "https://github.com/cherrypy/cherrypy/archive/${version}.tar.gz";
            #sha256 = "92358a0678425e42438f095f5d0d5c0fa60c02c62e21cb5872595e8d227a0f84";
        #};
    #});

    #mycherrypy = pkgs.lib.overrideDerivation python3Packages.cherrypy (attrs: rec {
        #version = "8.9.1";
        #name = "cherrypy-${version}";
        #doCheck = false;
        #src = pkgs.fetchurl {
            #url = "https://github.com/cherrypy/cherrypy/archive/v${version}.tar.gz";
            #sha256 = "0w3g837zc6pvsb6rhplp6fzbhvcswrdjjlkzqiqb4hllap3897wn";
        #};
    #});

    #buildInputs = [ python3 python3Packages.bottle python3Packages.pygments mycherrypy ];
    #buildInputs = [ python3 python3Packages.bottle python3Packages.pygments python3Packages.cherrypy ];
    #buildInputs = [ python3 python3Packages.bottle ];
    #buildInputs = [ python3 python3Packages.bottle python3Packages.cherrypy ];
    #buildInputs = [ python3 python3Packages.bottle mycherrypy ];
    buildInputs = [ python3 ];
  };
}

