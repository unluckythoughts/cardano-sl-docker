FROM alpine:latest

RUN apk update &&\
  apk add --no-cache git curl bzip2 bash openssl sudo &&\
  adduser -D -u 1000 cardano &&\
  echo "cardano ALL=NOPASSWD: ALL" >> /etc/sudoers &&\
  mkdir -m 0755 /nix &&\
  chown cardano /nix &&\
  mkdir -p /etc/nix &&\
  echo substituters = https://hydra.iohk.io https://cache.nixos.org/ > /etc/nix/nix.conf &&\
  echo trusted-substituters = >> /etc/nix/nix.conf &&\
  echo trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= >> /etc/nix/nix.conf &&\
  su - cardano -c 'git clone https://github.com/input-output-hk/cardano-sl.git /home/cardano/cardano-sl'

USER cardano
ENV USER cardano

RUN curl https://nixos.org/nix/install | sh

WORKDIR /home/cardano/cardano-sl
RUN git checkout master

RUN . /home/cardano/.nix-profile/etc/profile.d/nix.sh &&\
  nix-build -A cardano-sl-node-static --cores 0 --max-jobs 2 --no-build-output --out-link cardano-sl-1.0
RUN . /home/cardano/.nix-profile/etc/profile.d/nix.sh &&\
  nix-build -A connectScripts.mainnetWallet -o connect-to-mainnet
RUN . /home/cardano/.nix-profile/etc/profile.d/nix.sh &&\
  nix-build -A connectScripts.mainnetExplorer -o connect-explorer-to-mainnet

