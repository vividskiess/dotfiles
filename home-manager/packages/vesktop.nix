{ pkgs, lib, ... }: {

  options.programs.vesktop = {
    enable = mkEnableOption "vesktop";
    package = mkPackageOption pkgs "vesktop" { nullable = true; };
  };
}
