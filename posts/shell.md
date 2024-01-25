# My Setup and Other Things

I daily windows, so WSL, but am actively trying out Linux distros (feel free to recommend!)

Current list of issues stopping me from moving to Linux:
 - CAD Program Support (VM Solvable, but input latency issues which are suboptimal but acceptable)
 - OneDrive Files on Demand (soon to be phased out of my life)
 - AutoHotKey alternative
 - Notepad++ alternative
 - Logi Options+ alternative

## Shell

My shell is zsh running oh-my-zsh with powerlevel10k and zsh-autosuggestions

Install zsh first using whatever package manager the distro uses. Then run the following:

```sh
## Install zsh using package manager

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install powerlevel10k and set as zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME=.*/ZSH_THEME=powerlevel10k\/powerlevel10k/' ~/.zshrc

# get zsh autosuggestions and add to .zshrc plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i "s/^plugins=(/plugins=(\n    zsh-autosuggestions\n    /" ~/.zshrc
```


### Set vim to be the default terminal editor
Debian thing

```sh
sudo update-alternatives --config editor
```

### Set vim to be git's default editor

```sh
git config --global core.editor "vim"
```

### Set up a git repo

```sh
git init
git pull https://repo/address
git remote add origin https://repo/address
git push --set-upstream origin master
```

### Change around Mac's key layout

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

## Debian

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


### Frequently used packages

```sh
sudo apt install curl wget vim htop screen ffmpeg gparted exiftool binwalk basez qpdf nmap traceroute neofetch wireshark smartmontools 
```

## Arch

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
 - DE: KDE Plasma
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


### Delete 3D Objects

Open Registry Edit.

Go to

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\`

Delete `0DB7E...`.

Go to

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\`

Delete `0DB7E...`.

Then, Task Manager, restart File Explorer.






