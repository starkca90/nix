# Specifies release of Kubernetes to use for kubectl
# Currently using v1.27.12

# To update in the future, selected desired release tag from github.com/kubernetes/kubernetes
# Enter into version variable
#
# Run home-builder, it will fail about hash mismatch. Copy the "got" value to sha256 variable
# Re-run home-builder, should now compile and install desired kubectl version

final: prev:

let
  build = "2024.3.191333-latest";
  sha256 = "sha256-OywOjXzeW/5uyt50JrutiLgem9S1CrlwPFqfK6gUc7U=";
in
{
  lens = prev.lens.overrideAttrs (old: {
    inherit build;
    version = build;
    sources = prev.fetchurl {
      url = "https://api.k8slens.dev/binaries/Lens-${build}.x86_64.AppImage";
      inherit sha256;
    };
  });
}
