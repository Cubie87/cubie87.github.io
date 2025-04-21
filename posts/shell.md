# My Setup and Other Things

I daily windows, so WSL, and am actively working to move to Linux (debian) for my daily driver (laptop).

Current list of issues stopping me from moving to Linux:
 - CAD Program Support (VM Solvable, but input latency issues which are suboptimal but acceptable)
 - OneDrive Files on Demand (soon to be phased out of my life)
 - AutoHotKey alternative (I utilise hotstrings extensively)
 - Notepad++ alternative
 - Logi Options+ alternative

## Basic linux setup


```sh
# basic programs that I use
sudo apt install curl wget vim htop screen sysstat smartmontools gparted ffmpeg git unzip dnsutils glances screenfetch
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

### Change Grub Timeout
Grub's timeout. If >0, requires keyboard to be connected when booting. If =0, doesn't
```sh
sudo sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
sudo update-grub
```

### Set up git

```sh
# install repo
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
`gh auth login`
`gh auth setup-git`
```

```sh
git init
git pull https://repo/address
git remote add origin https://repo/address
git push --set-upstream origin master
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
# debian
#sudo update-initramfs -u
# arch
#sudo mkinitcpio -p linux
```

### GRUB Timeout

timeout=0 removes the need to have a keyboard plugged in during boot.

```sh
sudo vim /etc/default/grub

# change
GRUB_TIMEOUT=0
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
