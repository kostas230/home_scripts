#!/bin/sh

cd
rm -rf $HOME/.src
mkdir -p $HOME/.src
cd $HOME/.src 

## Mullvad
#  nvm
git clone https://aur.archlinux.org/nvm.git
cd nvm 
makepkg -sic 
cd ..

# mullvad-vpn
git clone https://aur.archlinux.org/mullvad-vpn.git
cd mullvad-vpn
gpg --recv-keys E52E9602E97DF111
gpg --recv-keys AEE9DECFD582E984
makepkg -sic 
cd ..

# mullvad-vpn-runit 
git clone https://aur.archlinux.org/mullvad-vpn-runit.git 
cd mullvad-vpn-runit
makepkg -sic 
#rc-service mullvad-daemon start
cd ..

# mullvad-browser-latest-bin
git clone https://aur.archlinux.org/mullvad-browser-latest-bin.git
cd mullvad-browser-latest-bin
gpg --recv-keys 157432CF78A65729
makepkg -sic 
cd ..


## 1password
git clone https://aur.archlinux.org/1password.git
cd 1password
gpg --recv-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
makepkg -sic 
cd ..

## Zoom
git clone https://aur.archlinux.org/zoom.git
cd zoom
makepkg -sic 
cd ..

## ZapZap
git clone https://aur.archlinux.org/zapzap.git
cd zapzap
makepkg -sic
cd ..

## Electron29
git clone https://aur.archlinux.org/electron29-bin.git
cd electron29-bin
makepkg -sic 
cd ..

## Caprine
git clone https://aur.archlinux.org/caprine-bin.git
cd caprine-bin
makepkg -sic
cd ..

## Linux Xanmod
git clone https://aur.archlinux.org/linux-xanmod.git
cd linux-xanmod
gpg --recv-keys 38DBBDC86092693E
env _microarchitecture=14 use_numa=y use_tracers=y _compiler_flags="CC=clang HOSTCC=clang LLVM=1 LLVM_IAS=1" _makenconfig=y makepkg -sic
cd ..
