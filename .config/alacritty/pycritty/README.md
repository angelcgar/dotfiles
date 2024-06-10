# Pycritty

Change your alacritty config on the fly!

![Preview Image](https://raw.githubusercontent.com/antoniosarosi/pycritty/master/preview.png)

## Installation:

```bash
pip install pycritty
```

By default, only the program itself will be installed, but you can install
default themes from [```config/themes```](https://github.com/antoniosarosi/pycritty/tree/master/config):

```bash
pip install --install-option="--themes=onedark,dracula,nord" pycritty
```

Or if you want them all:
```bash
pip install --install-option="--themes=all" pycritty
```

Make sure to have ```~/.local/bin``` directory in your ```$PATH```, otherwise
your shell won't find the ```pycritty``` command. Add this line to your
```~/.xprofile``` if you haven't already:

```bash
export PATH=$HOME/.local/bin:$PATH
```

Also if you are an Arch user you can install from the AUR (only the program will be installed)
```bash
git clone https://aur.archlinux.org/pycritty.git
cd pycritty
makepkg -si
```
Or with an AUR helper like yay
```bash
yay -S pycritty
```

## Usage:

Change your current config:

```bash
pycritty --font UbuntuMono --size 14 --opacity 0.95
```

Save multiple configs and reuse them later:

```bash
pycritty save ThisConfig
pycritty load AnotherConfig
```

Install themes and configs from URLs:
```bash
pycritty install -t https://raw.githubusercontent.com/antoniosarosi/pycritty/master/config/themes/breeze.yaml
pycritty -t breeze
pycritty install -c -n SomeCoolConfig https://raw.githubusercontent.com/antoniosarosi/dotfiles/master/.config/alacritty/config.yaml
pycritty load SomeCoolConfig
```

Check help for all available options:
```bash
pycritty -h
# pycritty subcomand -h
pycritty save -h
```

## Fonts Config

Fonts are configured in ```~/.config/alacritty/fonts.yaml``` with this format:
```yaml
fonts:
    Alias: Font Name
```

When applied using ```pycritty -f Alias```, the previous format will be
converted into the alacritty equivalent:

```yaml
font:
    normal:
        family: Font Name
    italic:
        family: Font Name
    bold:
        family: Font Name
```

You can also specify a different font for each font type:

```yaml
fonts:
    Alias:
        normal: Normal Font Name
        bold: Bold Font Name
        italic: Italic Font Name
```

Note that the fonts must be installed on your system.

## Theme Config

You can make your own custom themes by creating new theme files with the
correct format, ```~/.config/alacritty/themes/custom.yaml``` should look like
this:

```yaml
colors:
    # Default colors
    primary:
        background: '0x292d3e'
        foreground: '0xbbc5ff'
    # Normal colors
    normal:
        black:   '0x101010'
        red:     '0xf07178'
        green:   '0xc3e88d'
        yellow:  '0xffcb6b'
        blue:    '0x82aaff'
        magenta: '0xc792ea'
        cyan:    '0x89ddff'
        white:   '0xd0d0d0'
    # Bright colors
    bright:
        black:   '0x434758'
        red:     '0xff8b92'
        green:   '0xddffa7'
        yellow:  '0xffe585'
        blue:    '0x9cc4ff'
        magenta: '0xe1acff'
        cyan:    '0xa3f7ff'
        white:   '0xffffff'
```

Then you can apply it using the name of the file:

```bash
pycritty -t custom
```

## Custom scripts

If you want to apply different configs programmatically, you can either use
the CLI in a shell script or use ```pycritty``` as a python module:

```python
#!/bin/python3

# Dummy script that changes the theme every 5 minutes

from time import sleep
from pycritty.commands import Pycritty, ListResource


def main():
    ls = ListResource()
    conf = Pycritty()
    while True:
        for theme in ls.list_themes():
            conf.change_theme(theme)  # or conf.set(theme=theme)
            conf.apply()
            sleep(300)


if __name__ == '__main__':
    main()
```

Shell equivalent:

```bash
#!/bin/bash

while :; do
    # Same as pycritty ls --themes --iterable
    for theme in $(pycritty ls -ti); do
        pycritty -t $theme
        sleep 300
    done
done
```
