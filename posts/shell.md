# My Setup and Other Things

I daily windows, so WSL, but am actively trying out Linux distros (feel free to recommend!)

## Shell

My shell is zsh running oh-my-zsh with powerlevel10k

Install zsh first using whatever package manager the distro uses. Then run the following:

```sh
## Install zsh using package manager. Then run the following:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME=.*/ZSH_THEME=powerlevel10k\/powerlevel10k/' ~/.zshrc
```

### Setup zsh autosuggestions

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

```sh
vim ~/.zshrc

# add the following line to the plugins file
plugins=( 
    # other plugins...
    zsh-autosuggestions
)
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


## Frequently used packages

Debian
```sh
sudo apt install vim htop ffmpeg exiftool screen binwalk basez qpdf nmap traceroute neofetch
```

Arch
```sh
sudo pacman -S vim htop ffmpeg perl-image-exiftool screen binwalk qpdf nmap traceroute neofetch
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
    - `sudo pacman -S ssdm plasma-desktop konsole kscreen vim`
 - Wifi
    - `sudo pacman -S plasma-nm`
 - Audio
    - `sudo pacman -S plasma-pa`
 - Shell: zsh

Reboot

Start DE:
```sh
sudo systemctl enable sddm
sudo systemctl start sddm
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






