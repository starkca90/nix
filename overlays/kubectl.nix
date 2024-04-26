# Specifies release of Kubernetes to use for kubectl
# Currently using v1.27.12

# To update in the future, selected desired release tag from github.com/kubernetes/kubernetes
# Enter into version variable
#
# Run home-manager, it will fail about hash mismatch. Copy the "got" value to sha256 variable
# Re-run home-manager, should now compile and install desired kubectl version

final: prev:

let
  version = "1.28.9";
  sha256 = "sha256-YC9Yu0sjpSdtK7qbl7914IvGk3xu30lV6ihKdq/LLoc=";
in
{
  kubectl = prev.kubectl.overrideAttrs (old: {
    inherit version;
    src = prev.fetchFromGitHub {
      owner = "kubernetes";
      repo = "kubernetes";
      rev = "v${version}";
      hash = sha256;
    };
  });
}
