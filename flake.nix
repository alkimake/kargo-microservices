{
  description = "Kubernetes and Helm development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            kubectl
            kubernetes-helm
            k9s
            kubectx
            stern
            kubelogin
            # Additional useful tools
            yq-go    # YAML processor
            jq       # JSON processor
            cilium-cli
            hubble
            argocd
            kargo
          ];

          shellHook = ''
            echo "Kubernetes Development Environment"
            echo "Available tools:"
            echo "- kubectl: Kubernetes command-line tool"
            echo "- helm: Kubernetes package manager"
            echo "- k9s: Terminal UI for Kubernetes"
            echo "- kubectx/kubens: Tool for switching between clusters and namespaces"
            echo "- stern: Multi-pod/container log tailing"
            echo "- kubelogin: Kubernetes authentication helper"
            echo "- yq: YAML processor"
            echo "- jq: JSON processor"
          '';
        };
      });
}

