# Arch Linux (LVM over LUKS with Encrypted Boot)

# Step 1: Create a UEFI partition

fdisk /dev/sdX  (X is the disk you want to use)

1. Create a GPT partition
2. Create three partitions
  a) EFI ~100MB                       /dev/sdX1
  b) Linux LVM (Boot Partition) ~2GB  /dev/sdX2 
   c) Linux LVM > 24GB                 /dev/sdX3

# Step 2: Create the encrypted partitions

GRUB doesn't support booting from LUKS2, so we encrypt the boot partition
with LUKS1 and encrypt the rest with LUKS2. The boot partition should be 
about 2GB, unless you plan to use more than one kernel.

```
cryptsetup luksFormat --type luks1 /dev/sdX2
cryptsetup luksFormat /dev/sdX3
```

You will be asked to enter a password. DO NOT FORGET THIS PASSWORD.

```
cryptsetup open /dev/sdX2 cryptboot

cryptsetup open /dev/sdX3 cryptlvm

pvcreate --dataalignment 1m /dev/mapper/cryptlvm

vgcreate vg0 /dev/mapper/cryptlvm
```

Now we create the partitions.

Swap partition (for me it's 2GB, you can change it to whatever you want).

```
lvcreate -L 2G vg0 -n swap   
```
The / partition. Again, depends on your uses. 60 GB should be plenty enough.

```
lvcreate -L 60G vg0 -n root
```

The rest of the space is used for the /home partition

```
lvcreate -l 100%FREE vg0 -n home
```

# Step 3: Format the partitions

```
mkfs.vfat -F32 /dev/sdX1
mkfs.ext4 /dev/mapper/cryptboot
mkswap /dev/cryptlvm/swap
mkfs.ext4 /dev/cryptlvm/root
mkfs.ext4 /dev/cryptlvm/home
```

# Step 4: Mount the partitions and generate /etc/fstab file

```
swapon /dev/cryptlvm/swap
mount /dev/cryptlvm/root /mnt
mkdir /mnt/boot
mkdir /mnt/home 
mount /dev/cryptlvm/home /mnt/home
genfstab -U -p /mnt >> /mnt/etc/fstab
mkdir /mnt/boot
mount /dev/mapper/cryptboot /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sdX1 /mnt/boot/efi
```
At this stage, fstab should only include entries for swap, root and home partitions.
Double check, otherwise your system won't boot. 

# Step 5: Install the necessary packages

```
pacstrap -i /mnt base base-devel linux-zen linux-zen-headers linux-firmware \
openssh iwctl wpa_supplicant wireless_tools openresolv dialog lvm2 grub efibootmgr \
dosfstools mtools nano zsh os-prober wget curl git apparmor unrar unzip cups vim xsane \
sane-gt68xx-firmware sane-frontends ranger zathura w3m xf86-video-intel libva-intel-driver \
mesa mpv vlc libreoffice firefox geeqie gimp electron telegram-desktop transmission-gtk \
xterm xscreensaver mutt feh xorg xorg-server xorg-apps xorg-xinit xorg-xclock \
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
mkinitcpio -P
```

If you installed the generic linux kernel "linux" or the LTS kernel "linux-lts" then you replace
"linux-hardened" with "linux" or "linux-lts" respectively.

This will create the ram img. 

Now you need to write down the UUID of /dev/sdX3. Use this command.

```
blkid /dev/sdX2
```

Now go to /etc/default/grub and edit the following lines:

```
GRUB_CMDLINE_LINUX=" ... cryptdevice=UUID=*sdX3-UUID*:cryptlvm root=/dev/vg0/root ... "
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

Next, we generate the GRUB configuration file.

```
grub-mkconfig -o /boot/grub/grub.cfg
```
After this, Arch should be able to boot successfully. If you also want the /boot partition
to be mounted during boot, you have to make the following modifications. 

The first step is to generate a key for automatic opening of /dev/sdX2.

```
dd bs=512 count=4 if=/dev/random of=/etc/cryptsetup-keys.d/cryptboot.key  iflag=fullblock
chmod 600 /etc/cryptsetup-keys.d/cryptboot.key
cryptsetup -v luksAddKey /dev/sdX2 /etc/cryptsetup-keys.d/cryptboot.key
```

Next, you open /etc/crypttab and add the following line 
```
cryptboot  UUID=*sdX2-UUID*  /etc/cryptsetup-keys.d/cryptboot.key
```
This is for Arch to open /dev/sdX2 as /dev/mapper/cryptboot during booting. To mount it, 
simply add the following line in /etc/fstab
```
/dev/mapper/cryptboot  /boot  ext4  rw,relatime  0 2
```

After this, you can proceed with the usual installation of Arch Linux and reboot. 

You will be asked for the password for the ecrypted drive two times. The first is for GRUB
to access the /boot partition, and the second time is to access to boot linux. 
