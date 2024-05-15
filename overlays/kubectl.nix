# Specifies release of Kubernetes to use for kubectl
# Currently using v1.27.12

# To update in the future, selected desired release tag from github.com/kubernetes/kubernetes
# Enter into version variable
#
# Run home-manager, it will fail about hash mismatch. Copy the "got" value to sha256 variable
# Re-run home-manager, should now compile and install desired kubectl version

final: prev:

let
  version = "1.28.10";
  sha256 = "sha256-1iJ+rqWNl7VjRgFRX4w1/ykeOSAABSC0/HnqWQOytpM=";
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
