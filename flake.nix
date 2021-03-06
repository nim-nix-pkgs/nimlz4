{
  description = ''Nim wrapper for the LZ4 library. There is also a high-level API for easy use'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."nimlz4-master".dir   = "master";
  inputs."nimlz4-master".owner = "nim-nix-pkgs";
  inputs."nimlz4-master".ref   = "master";
  inputs."nimlz4-master".repo  = "nimlz4";
  inputs."nimlz4-master".type  = "github";
  inputs."nimlz4-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimlz4-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}