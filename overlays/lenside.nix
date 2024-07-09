# Specifies release of Lens IDE to use
# Currently using 2024.5.271333

# To update in the future, selected desired release tag from https://k8slens.dev/download
# Enter into version variable
#
# Run home-manager, it will fail about hash mismatch. Copy the "got" value to sha256 variable
# Re-run home-manager, should now compile and install desired kubectl version

final: prev:

let
  version = "2024.5.271333";
  sha256 = "sha256-1iJ+rqWNl7VjRgFRX4w1/ykeOSAABSC0/HnqWQOytpM=";
in
{
  lens = prev.lens.overrideAttrs (old: {
    inherit version;
    sources = {
      x86_64-linux = {
        url = "https://api.k8slens.dev/binaries/Lens-${version}-latest.x86_64.AppImage";
        hash = sha256;
      };
      x86_64-darwin = {
        url = "https://api.k8slens.dev/binaries/Lens-${version}-latest.dmg";
        hash = "sha256-yf+WBcOdOM3XsfiXJThVws2r84vG2jwfNV1c+sq6A4s=";
      };
      aarch64-darwin = {
        url = "https://api.k8slens.dev/binaries/Lens-${version}-latest-arm64.dmg";
        hash = "sha256-hhd8MnwKWpvG7UebkeEoztS45SJVnpvvJ9Zy+y5swik=";
      };
    };
  });
}
