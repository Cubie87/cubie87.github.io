# ZSH setup on WSL

I daily windows don't judge.


## Setup zsh

Set up zsh on a non-zsh system (I usually use Ubuntu 22.04)

```bash
sudo apt install zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

sed -i 's/ZSH_THEME=.*/ZSH_THEME=powerlevel10k\/powerlevel10k/' ~/.zshrc
```



## Setup zsh autosuggestions

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

```bash
vim ~/.zshrc

# add the following line to the plugins
plugins=( 
    # other plugins...
    zsh-autosuggestions
)
```
