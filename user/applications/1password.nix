{ ... }:

let
  onePassPath = "~/.1password/agent.sock";
in {
  programs.ssh = {
    matchBlocks = {
      "*" = {
        extraOptions.IdentityAgent = onePassPath;
      };
    };
  };
}
