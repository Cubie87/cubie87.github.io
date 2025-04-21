# Surface Go

## Selection and Acquisition

I've been wondering what a tablet experience would be like in my life. I've used iPad Airs before (specifically the M1) but the animation speed and general scroll jelly makes it almost impossible for me to use, not to mention issues that I encounter with Apple software in general.

To this end, I sought out a Microsoft Surface device, with the requirement that it had to be able to charge over USB C. At time of writing, all devices in my life utilise either USB C charging or Qi Wireless, and I was not about to start carrying around more chargers. Unfortunately, due to Microsoft's decision to utilise Mini-DP for the longest time, this limited my options to Surface Pro 7 and above, Surface Laptop 3 and above, Surface Book 2 and above, and any Surface Go laptops or Surface Go tablets. 

As I was looking to utilise a tablet, the laptops were prioritised lower than the Pro and Go, and the Surface Book was entirely discounted. Furthermore, as I already had enough compute devices in my life, I was not looking for a powerful machine, which meant that all tablets were considered equally. As cost was also a consideration, I ventured onto online auction sites, eBay, and local marketplace vendors, before acquiring a base spec Surface Go Gen1.

Specs:
- Intel Pentium 4415Y
- 4GB RAM
- 64GB eMMC Storage
Came with typecover (yay) and surface charger (meh)

Amazingly, the battery only had 99 charge cycles when I got it. Pretty good for a device that was released \*checks calendar\* oh god 2016. 26Whr battery, not bad.

Given this spec, I had minimal interest in running windows on this, and wanted to try Linux.

## Installing Linux

It had been reset to the Windows 10 OOBE screen, which I was able to bypass (Ctrl+Shift+F3) to get to the desktop, which from there, I could reboot into UEFI. Changing the boot order to prefer USB Boot, it would refuse to accept my Debian install USB, and instead went back to Windows. Eventually I found out that this is due to Microsoft Surfaces refusing to boot from drives unless they're **NTFS Formatted GPT** partitions. WHY?!

Thankfully, Ventoy was the answer, and allowed me to boot into the Debian 12 installer without issue.

As it was a portable device, I installed it with LUKS Disk Encryption.

As it was a touchscreen, I installed the Gnome DE without any optional features.

As the drive was _slow_ (eMMC, not an SSD but more akin to MicroSD or USB drives), the install took a good 30 minutes. God damn.

## Get TPM working with LUKS

All the surface products that were considered above, comes with TPM. I utilised a script from [Stack Exchange](https://askubuntu.com/questions/1470391/luks-tpm2-auto-unlock-at-boot-systemd-cryptenroll)

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


Reboot and ensure that this works. If not, reinstall time! 

## Install Programs and Customise OS

First things first, let's install my basic software suite from [my setup](../shell.md). I excluded `smartmontools` and `ffmpeg` as the former does not work on eMMC, and the computer is far too weak for the latter.

Install `zsh`, use vim, change grub timeout. Typical.

One odd addition here, is utilising the [custom linux kernel for surface devices](https://github.com/linux-surface/linux-surface), which gives you a lot more features.

I also installed `vlc intel-microcode amd64-microcode intel-media-va-driver intel-gpu-tools libva-intel-driver mesa-utils mmc-utils` mostly for hardware video enc/dec/transcode. `mmc-utils` replaces `smartmontools`.

Furthermore, I removed all the Gnome bloat, the games it comes with and libreoffice.

## RAM/SWAP Configuration

Since there is so little ram, the system eagerly utilises SWAP. But the eMMC storage is known to be _extremely_ slow compared to RAM, so I wanted it to avoid SWAP unless at all possible. 

This can be done in linux to prefer one or the other! Amazing.

Copied and pasted from linux kernel documentation
```txt
swappiness
==========

This control is used to define the rough relative IO cost of swapping and filesystem paging, as a value between 0 and 200. At 100, the VM assumes equal IO cost and will thus apply memory pressure to the page cache and swap-backed pages equally; lower values signify more expensive swap IO, higher values indicates cheaper.

Keep in mind that filesystem IO patterns under memory pressure tend to be more efficient than swap's random IO. An optimal value will require experimentation and will also be workload-dependent.

The default value is 60
```
After doing some trials, I settled on `Swappiness = 15`

```sh
# check what the current value is
cat /proc/sys/vm/swappiness

sudo vim /etc/sysctl.d/99-swappiness.conf
# add:
# vm.swappiness=15
# save and exit

sudo sysctl -p /etc/sysctl.d/99-swappiness.conf
```


## Gnome Settings

Oh boy there's a lot here.

Gnome fractional scaling is an experimental Feature.

```sh
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
```

I have mine set to 125%. Better than Windows fractional scaling.


### Gnome Extensions

- Dash To Panel
  - Position:
    - Panel Screen Pos: Top
    - Panel Thickness: 32px
  - Style:
    - Icon Margin: 2px
    - Padding: 6px
    - Run Indicator: Top
    - Style (focused): solid, 2px
    - Style (unfocussed): dashes
- Notification Banner Reloaded
  - Hpos: Right
  - Vpos: Bottom
  - Anim Dir: Slide from Right
- Screen Rotate 
  - Default Settings
- system-monitor-next
  - Only show CPU and Memory, Display style Digits.
- Tailscale QS

