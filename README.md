# Arch Linux (LVM over LUKS with Encrypted Boot)

# Step 1: Create a UEFI partition

fdisk /dev/sdX  (X is the disk you want to use)

1. Create a GPT partition
2. Create two partitions
  a) EFI ~512MB             /dev/sdX1
  b) Linux LVM > 24GB       /dev/sdX2

# Step 2: Create the encrypted partitions

```
cryptsetup luksFormat --type luks1 /dev/sdX2
```

You will be asked to enter a password. DO NOT FORGET THIS PASSWORD.

```
cryptsetup open --type luks1 /dev/sdX2 cryptlvm

pvcreate --dataalignment 1m /dev/mapper/cryptlvm

vgcreate volgroup0 /dev/mapper/cryptlvm
```

Now we create the partitions.

Swap partition (for me it's 2GB, you can change it to whatever you want).

```
lvcreate -L 2G volgroup0 -n lv_swap   
```

Boot partition. 2GB should be fine unless you plan to use more kernels.

```
lvcreate -L 2G volgroup0 -n lv_boot
```

The /root partition. Again, depends on your uses. 60 GB should be plenty enough.

```
lvcreate -L 60G volgroup0 -n lv_root
```

The rest of the space is used for the /home partition

```
lvcreate -l 100%FREE volgroup0 -n lv_home
```

# Step 3: Format the partitions

```
mkfs.vfat -F32 /dev/sdX1
mkswap /dev/cryptlvm/lv_swap
mkfs.ext2 /dev/cryptlvm/lv_boot
mkfs.ext4 /dev/cryptlvm/lv_root
mkfs.ext4 /dev/cryptlvm/lv_home
```

# Step 4: Mount the partitions and generate /etc/fstab file

```
mount /dev/cryptlvm/lv_root /mnt
mkdir /mnt/boot
mkdir /mnt/home 
mount /dev/cryptlvm/lv_boot /mnt/boot
mount /dev/cryptlvm/lv_home /mnt/home
swapon /dev/cryptlvm/lv_swap
genfstab -U -p /mnt >> /mnt/etc/fstab
mkdir /mnt/boot/efi
mount /dev/sdX1 /mnt/boot/efi
```

# Step 5: Install the necessary packages

```
pacstrap -i /mnt base base-devel linux-hardened linux-hardened-headers linux-firmware \
openssh networkmanager wpa_supplicant wireless_tools netctl dialog lvm2 grub efibootmgr \
dosfstools mtools nano zsh os-prober wget curl git apparmor unrar unzip cups vim xsane \
sane-gt68xx-firmware sane-frontends ranger zathura w3m xf86-video-intel libva-intel-driver \
mesa mpv vlc libreoffice firefox geeqie gimp electron telegram-desktop transmission-gtk \
rxvt-unicode xscreensaver mutt feh xorg xorg-server xorg-apps xorg-xinit xorg-xclock \
tamsyn-font terminus-font bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid \
gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts font-bh-ttf \
ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code \
ttf-fantasque-sans-mono ttf-fira-mono ttf-fira-code ttf-hack ttf-inconsolata \
ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts gnu-free-fonts ttf-opensans \
gentium-plus-font ttf-junicode xorg-fonts-type1 otf-latin-modern otf-latinmodern-math
```

# Step 6: chroot into the installation

```
arch-chroot /mnt
```

# Step 7: Configure the bootloader

Go to /etc/mkinitcpio.conf and configure the HOOKS=... line to look like this

```
HOOKS=(base udev autodetect keyboard keymap consolefont modconf encrypt lvm2 filesystems fsck)
```

Save and then execute the following command.

```
mkinitcpio -p linux-hardened
```

If you installed the generic linux kernel "linux" or the LTS kernel "linux-lts" then you replace
"linux-hardened" with "linux" or "linux-lts" respectively.

This will create the ram img. 

Now you need to write down the UUID of /dev/sdX2. Use this command.

```
blkid /dev/sdX2
```

Now go to /etc/default/grub and edit the following lines:

```
GRUB_CMDLINE_LINUX=" ... cryptdevice=UUID=*sdX2-UUID*:cryptlvm ... "
GRUB_ENABLE_CRYPTODISK=y
```

Save and exit. 

Install the GRUB bootloader using this command.

```
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck
```

In some devices the EFI created are not detected at boot. To prevent boot errors issue
the following commands.

```
mkdir /boot/efi/EFI/BOOT
cp /boot/efi/EFI/GRUB/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI
```

The onlt thing that remains now is to create the grub configuration file. 

```
grub-mkconfig -o /boot/grub/grub.cfg
```

After this, you can proceed with the usual installation of Arch Linux and reboot. 

You will be asked for the password for the ecrypted drive two times. The first is for GRUB
to access the /boot partition, and the second time is to access to boot linux. 
