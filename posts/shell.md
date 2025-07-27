# My Setup and Other Things

I daily windows, so WSL, and am actively working to move to Linux (debian) for my daily driver (laptop).

Current list of issues stopping me from moving to Linux:
 - CAD Program Support (VM Solvable, but input latency issues which are suboptimal but acceptable)
 - AutoHotKey alternative (I utilise hotstrings extensively)
 - Logi Options+ alternative

I've now moved over to Debian/KDE as my daily driver!

## Basic linux setup

```sh
# basic programs that I use
sudo apt install curl wget vim htop screen sysstat smartmontools ffmpeg git unzip dnsutils glances screenfetch
# ctf tools
sudo apt install libimage-exiftool-perl binwalk basez qpdf nmap traceroute wireshark python-is-python3 python3-pip netcat-traditional ncat 


# install zsh
sudo apt install zsh
# install oh-my-zsh for customisation
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install powerlevel10k and set as zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME=.*/ZSH_THEME=powerlevel10k\/powerlevel10k/' ~/.zshrc
# get zsh autosuggestions and add to .zshrc plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i "s/^plugins=(/plugins=(\n    zsh-autosuggestions\n    /" ~/.zshrc
# install zsh-syntax-highlighting
sudo apt install zsh-syntax-highlighting
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
# set as default shell
chsh -s $(which zsh)


# set up vim to be default terminal editor
sudo update-alternatives --config editor
# vim default git editor
git config --global core.editor "vim"
```

### GUI Programs
Requires external repos/pgp keys that may change.
- [Sublime Text](https://www.sublimetext.com/docs/linux_repositories.html)
- [Firefox](https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions-recommended)

```sh
sudo apt update
# gui programs that I use
sudo apt install gparted vlc obs-studio firefox-nightly firefox-devedition sublime-text 
```

### yt-dlp

[Download](https://github.com/yt-dlp/yt-dlp)
```sh
cd ~
echo '\n\n'alias :yt-dlp=\'/home/$USER/yt-dlp --no-overwrites --merge-output-format \"mkv\" --output \"'%(upload_date)s - %(title)s-%(id)s.%(ext)s'\"\'  >> .zshrc
```


### Change Grub Timeout
Grub's timeout. If >0, requires keyboard to be connected when booting. If =0, doesn't
```sh
sudo sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
sudo update-grub
```

### Framework Laptop

Use the [debian guide](https://wiki.debian.org/InstallingDebianOn/FrameWork/Laptop13/AMD_7040_Series) first.

REMEMBER to fix display drivers FIRST!!!

#### KDE Settings to change.

- Appearance: Breeze Dark
- Workspace Behaviour > General: Animation Speed: 3/4 -->
- Workspace Behaviour > General: Clicking files or folders: Selects them
- Workspace Behaviour > Screen Edges: Top Left, Nothing
- Input Devices > Mouse > MX Anywhere: Enabled
- Input Devices > Mouse > MX Anywhere: Acceleration: Flat
- Input Devices > Mouse > MX Anywhere: Disable Invert Scroll
- Input Devices > Mouse > MX Anywhere: Scroll Speed: 5th from the left
- Input Devices > Mouse > MX Anywhere: Rebind buttons as you see fit
- Input Devices > Touchpad: Tap to Click
- Input Devices > Touchpad: Two finger tap: Right click 
- Input Devices > Touchpad: Invert scroll direction
- Input Devices > Touchpad: Scroll Speed 2nd from left
- Input Devices > Touchpad: Right Click: press anywhere with 2 fingers
- Power Management > AC Power: Disable suspend session


#### Fingerprint Reader

```sh
sudo apt install fprintd libpam-fprintd
sudo pam-auth-update
```
BUT remember to add this to `/etc/pam.d/sddm` after the first `auth` lines to ensure you can login.
```sh
#auth            something       something blah
# fingerprint-testing stuff
auth            [success=1 new_authtok_reqd=1 default=ignore]   pam_unix.so try_first_pass likeauth nullok
auth            sufficient      pam_fprintd.so
```


### Get Video Loopback devices working
Need to perform MOK management

```sh
sudo apt install v4l2loopback-dkms
openssl req -new -x509 -newkey rsa:2048 -outform DER -keyout MOK.priv -out MOK.der -nodes -days 36500 -subj "/CN=v4l2ModuleKey/"
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der /lib/modules/$(uname -r)/updates/dkms/v4l2loopback.ko

sudo mokutil --import MOK.der
sudo reboot
```

At the boot screen:
- Choose "Enroll MOK"
- Select "Continue"
- Choose "Yes"
- Enter the password you set earlier

```sh
sudo modprobe v4l2loopback
```


### Virtualbox

[VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads)

```sh
# sudo apt install virtualbox
sudo mkdir -p /var/lib/shim-signed/mok
sudo openssl req -nodes -new -x509 -newkey rsa:2048 -outform DER -addext "extendedKeyUsage=codeSigning" -keyout /var/lib/shim-signed/mok/MOK.priv -out /var/lib/shim-signed/mok/MOK.der
sudo mokutil --import /var/lib/shim-signed/mok/MOK.der
# sign kernel modules
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der /usr/lib/modules/6.1.0-37-amd64/misc/vboxdrv.ko
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der /usr/lib/modules/6.1.0-37-amd64/misc/vboxnetadp.ko
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der /usr/lib/modules/6.1.0-37-amd64/misc/vboxnetflt.ko
sudo reboot
```


### Set up git

```sh
# install repo
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
gh auth login`
gh auth setup-git`
```

```sh
git init
git pull https://repo/address
git remote add origin https://repo/address
git push --set-upstream origin master
```

### LUKS and TPM2 AutoUnlock

```sh
sudo apt install tpm2-tools
sudo apt install libtpm2-pkcs11-1
sudo apt install dracut

# sudo systemd-cryptenroll --tpm2-device=auto /dev/nvme0n1p3
sudo systemd-cryptenroll --wipe-slot tpm2 --tpm2-device auto --tpm2-pcrs "1+7" /dev/nvme0n1p3
```

edit `/etc/dracut.conf` so it just contains:
```
add_dracutmodules+=" tpm2-tss crypt "
```

edit `/etc/dracut.conf.d/tss2.conf
````
install_optional_items+=" /usr/lib64/libtss2* /usr/lib64/libfido2.so.* " 
```

`/etc/default/grub` and replace that line with:
```
GRUB_CMDLINE_LINUX="rd.auto rd.luks=1"
```

`/etc/crypttab` and comment out the line.
```
## nvme0n1p3_crypt UUID=****-****-*** none luks,discard
```

```sh
dracut -f
update-grub
```

Reboot.


To delete: 
```
sudo systemd-cryptenroll --wipe-slot=tpm2 /dev/nvme0n1p3
```

helpful command when chrooted if you break the install.
```
dracut --regenerate-all --force
```


### Chroot into a device with LUKS using TailsOS

```sh
sudo fdisk -l
# /dev/nvme0n1p1: EFI
# /dev/nvme0n1p2: /boot
# /dev/nvme0n1p3: / (encrypted)

sudo cryptsetup open /dev/nvme0n1p3 temp-name-here

sudo mount /dev/mapper/temp-name-here /mnt
cd /mnt
sudo mount /dev/nvme0n1p2 boot/
sudo mount -t proc /proc proc/
sudo mount --rbind /dev dev/
sudo mount --make-rslave dev/
sudo mount --rbind /sys sys/
sudo mount --make-rslave sys/
sudo chroot .
```

### Change Around Mac's God Awful Key Layout

This swaps `fn` with `ctrl`, and swaps `alt` with `meta`. It also changes function keys to default to F1-12 as opposed to brightness/etc.

```sh
sudo vim /etc/modprobe.d/hid_apple.conf

# append this to file
options hid_apple fnmode=2
options hid_apple swap_fn_leftctrl=1
options hid_apple swap_opt_cmd=1

# regenerate initramfs
sudo update-initramfs -u
#sudo mkinitcpio -p linux # for kali
```

### Kali Install

When installing Kali Linux on a MacbookPro12,1 using Rufus, write in GPT, DD mode, not ISO

### Samba Share Setup

```sh
sudo apt install samba
mkdir ~/share

sudo vim /etc/samba/smb.conf

## append
[share]
    comment = Samba Shared Folder
    path = /home/[username]/share
    read only = no
    browsable = yes
# write exit file

sudo service smbd restart
sudo ufw allow samba

sudo smbpasswd -a [user]
```

### Static IP 

```sh
sudo vim /etc/network/interfaces

## change your default ethernet interface (eno0 for this example)
auto eno0
iface eno0 inet static
    address 192.168.X.Y
    netmask 255.255.255.0
    gateway 192.168.X.X
# use whatever your network uses
# write exit
```

### Python pip fix

```sh
sudo mv /usr/lib/python3.11/EXTERNALLY-MANAGED /usr/lib/python3.11/EXTERNALLY-MANAGED.old
```


### LaTeX Installation

```sh
# add keyring
curl -fsSL https://miktex.org/download/key | sudo tee /usr/share/keyrings/miktex-keyring.asc > /dev/null
# add source
echo "deb [signed-by=/usr/share/keyrings/miktex-keyring.asc] https://miktex.org/download/debian bookworm universe" | sudo tee /etc/apt/sources.list.d/miktex.list
# install
sudo apt-get update
sudo apt-get install miktex
# finish install
miktexsetup finish 
# configure to download packages as needed
initexmf --set-config-value="[MPM]AutoInstall=1"
# install pdflatex
sudo apt install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
```

Fix pygmentize

```sh
pip3 install pygments
# add to path if not already
#export PATH="$PATH:/home/[USERNAME]/.local/bin"
pygmentize -V
```

### Surface Go TPM LUKS
```sh
#!/bin/bash

#install needed packages
apt-get -y install clevis clevis-tpm2 clevis-luks clevis-initramfs initramfs-tools tss2

#proceed
echo -n Enter LUKS password:
read -s LUKSKEY
echo ""

clevis luks bind -d /dev/nvme0n1p3 tpm2 '{"pcr_bank":"sha256"}' <<< "$LUKSKEY"

update-initramfs -u -k all

#check
clevis luks list -d /dev/nvme0n1p3

#delete example; -s is one of the slots reported by the previous command
#clevis luks unbind -d /dev/nvme0n1p3 -s 1 tpm2
```
Gnome Fractional Scaling
```sh
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
```


## Misc Windows Commands

### Delete Cortana (Win10 only)

Powershell

```powershell
Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage
```

### Delete Other Windows 10 Bloat

Powershell

```powershell
Get-AppxPackage *phone* | Remove-AppxPackage
Get-AppxPackage *xbox* | Remove-AppxPackage
Get-AppxPackage *feedback* | Remove-AppxPackage
Get-AppxPackage *tv* | Remove-AppxPackage
Get-AppxPackage *film* | Remove-AppxPackage
Get-AppxPackage *calendar* | Remove-AppxPackage
Get-AppxPackage *camera* | Remove-AppxPackage
Get-AppxPackage *alarm* | Remove-AppxPackage
Get-AppxPackage *help* | Remove-AppxPackage
Get-AppxPackage *groove* | Remove-AppxPackage
Get-AppxPackage *maps* | Remove-AppxPackage
Get-AppxPackage *mixed* | Remove-AppxPackage
Get-AppxPackage *solit* | Remove-AppxPackage
Get-AppxPackage *people* | Remove-AppxPackage
Get-AppxPackage *3D* | Remove-AppxPackage
Get-AppxPackage *experience* | Remove-AppxPackage
```

### Kill WSL

Powershell

```powershell
taskkill /F /im wslservice.exe
```

### wslconfig

C:/Users/USER/.wslconfig

```conf
# Settings apply across all Linux distros running on WSL 2
[wsl2]

# Limits VM memory to use no more than 4 GB, this can be set as whole numbers using GB or MB
memory=4GB 

# Sets the VM to use two virtual processors
processors=2

```

### Delete 3D Objects

Open Registry Edit.

Go to

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\`

Delete `0DB7E...`.

Go to

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\`

Delete `0DB7E...`.

Then, Task Manager, restart File Explorer.







## Arch (legacy)

Before installing, refresh pacman keys cause the ones in the iso were out of date.

```sh
pacman-key --refresh-keys
```

I used archinstall, couldn't get bootloaders to work on my Mac (I personally blame the mac).

```sh
archinstall
```

Once installed chroot in and install the following before exiting out of the install environment.

 - Display Server: Xorg
    - `sudo pacman -Ss xf86-video-intel` (for Macbook Pro 12,1)
 - DE: KDE Plasma (with Konsole as terminal window, and of course vim)
    - `sudo pacman -S sddm plasma-desktop konsole vim`
 - Display Scaling
    - `sudo pacman -S kscreen`
 - Wifi
    - `sudo pacman -S plasma-nm`
 - Audio
    - `sudo pacman -S plasma-pa`
 - Shell: [zsh](#shell)

Reboot

Start DE:
```sh
sudo systemctl enable sddm
sudo systemctl start sddm
```

### Frequently used packages

```sh
sudo pacman -S vim htop ffmpeg perl-image-exiftool screen binwalk qpdf nmap traceroute neofetch wireshark-qt curl wget smartmontools
```
```sh
sudo yay -S basez ulauncher 
```
