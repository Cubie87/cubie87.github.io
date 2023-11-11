# Blog Writing

This blog/website is hosted on github pages cause... well, free. 

Setup wasn't too difficult, just following github pages guides.

 - Make Repo
 - Name it [username].github.io
 - Add and commit `.md` files
 - Push

Github will recognise it, build, and host, for you.

I'm not a front end person, so all of these are in `.md` I apologise in advance, but makes my life infinitely easier.

I will be backdating some of my older projects as I see fit, mostly as they are notable enough for me to preserve my thought processes, but also to help with populating the site.

I want to work on having a comments/pr section so there can be some interaction, but obviously pending ease of setup (and dependencies! if a dependency goes offline (repo gets deleted), how easy is it to re-set-up using another dependency?).


## Data Considerations

I'm always concerned about data longetivity. All of the cloud based web service providers are cool and all, but if they ever shut down, where does my uploaded content go? Can I have a local backup? How easily transferrable is it? These questions are the main driving goal for this.

Consider: Home internet has only been a thing for around 20 years, how do you plan around data longetivity knowing this? I want to have access to all of my data long into the future, when the tech scene may have changed dramatically. How transferable is all my data? Is it all backed up? What happens if \[provider\] goes offline/shuts down/gets hacked?

## Updating the Theme

I was using the default `_config.yml` file with remote themes (jekyll's minima) for the styling of the site, but it had a god damn rss button that I disliked, and also couldn't render $\LaTeX$ syntax. With the help of ChatGPT, I was able to make the theming local (no remote themes) by cloning over the minima repo. This meant that I could just yeet the rss section in the html template, but also means that I'll now be responsible for maintainence and upkeep of the theme. Given that it's a static site that has no interactive elements, security considerations are low, and I can always just re-copy/paste from the repo when they update the theme.

Adding $\LaTeX$ rendering was more interesting, involving editing the head.html file, and adding a mathjax html file as well. I only have a very basic understanding of frontend html/css/js, having made some _very_ basic websites previously, so only had a high level overview of everything, but it WORKS NOW :DD I'm so happy.

Have the Riemann Zeta Function (really nice to typeset)

$$\zeta (s) = \sum_{n=1}^{\infty} \frac{1}{n^s}$$


