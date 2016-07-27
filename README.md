# SDR tools for Mac

After the excellent prior work found at [robotastic/homebrew-hackrf][rtrepo] and [metacollin/homebrew-gnuradio][mcrepo], I decided to create a full suite of gnuradio-based tools targeting the 3.7 release of [GNU Radio][gnuradio].

One of the goals of this repository is to allow native Mac OS X use of the HackRF for [Great Scott Gadgets' free online SDR course][gsgsdrcourse].

## What's included

* GNU Radio with GNU Radio Companion: `gnuradio`
* The gqrx general-purpose tuner: `gqrx`
* [gr-baz][grbaz], a collection of extra blocks for GNU Radio: `gr-baz`
* [gr-osmosdr][grosmosdr], an abstraction layer supporting a variety of hardware: `gr-osmosdr`
* RTL-SDR libraries and utilities: `rtlsdr`

HackRF libraries and utilities now live in mainline Homebrew as `hackrf`.

## Before you build

### Switch off bottles

Homebrew uses 'bottles', which are binary distribution packages, to speed up installation of many formulae. Unfortunately, all bottles use Apple's Python interpreter, which will be a problem. You have two choices here -

* Use the `--build-from-source` parameter for every operation. This will disable the use of bottles for that command.
* Disable the use of bottles entirely.

I strongly recommend you disable the use of bottles entirely. To do this, simply add the following line to your shell init file - `.bashrc`, `.zshrc`, or similar...

`export HOMEBREW_BUILD_FROM_SOURCE=1`

...and then restart your shell (closing and reopening your terminal application will work fine). I'll include the `--build-from-source` parameter in all the commands I quote for people who can't or won't make that change, but if you have this line in your shell config they're optional.

### Install Xquartz if you haven't already

Grab [the latest development version of Xquartz][xquartz] and install it. Reboot your machine after it's installed.

### Install Homebrew Python 2.x, and use it as your default Python

This is out of scope for this document, but it's not hard. My recommendations for setting it up are:

* First, install Homebrew's Tcl/Tk (it's in `homebrew/dupes`) with threading enabled.
* Then install Homebrew's Python using Homebrew's Tcl/Tk (`--with-tcl-tk`).

### Reboot

Entirely optional, but it'll make sure that everything's running smoothly.

## Building

#### If any of the packages are already installed, substitute `brew install` for `brew reinstall` to make sure they're compiled with the proper options.

#### All commands should be executed as a normal user; don't use `sudo`.

First, we need to get `libxml` and `libxslt` compiled and linked, even though Homebrew warns about keg-only. I've not experienced problems; YMMV. 

```
brew install --build-from-source libxml2 --with-python
brew install --build-from-source libxslt
brew link libxml2 --force
brew link libxslt --force
```

Next let's get the GNU Radio Python dependencies installed. If this fails with permission issues, you're probably not using Homebrew Python. You need to fix that and then start again.

```
pip install Cheetah lxml matplotlib numpy scipy docutils sphinx
```

Now we need to bring the formulae in this repo into Homebrew.

```
brew tap daveio/sdrtools
brew update
```

Next we build WX and Boost.

```
brew install --build-from-source --python wxmac
brew install --build-from-source --with-icu4c boost
```

And now it's time for GNU Radio itself.

```
brew install --build-from-source gnuradio
```

Next comes the GNU Radio extras and hardware support.

```
brew install --build-from-source --HEAD gr-baz
brew install --build-from-source --HEAD rtlsdr
brew install --build-from-source hackrf
brew install --build-from-source --HEAD gr-osmosdr
```

Create the ~/.gnuradio/config.conf config file for custom block support and add this into it

```
[grc]
local_blocks_path=/usr/local/share/gnuradio/grc/blocks
```

Finally, we build gqrx.

```
brew install --build-from-source --HEAD gqrx
```

## Running the tools

To start gqrx:

`gqrx`

To start GNU Radio Companion:

`gnuradio-companion`

I won't list the individual tools for HackRF and RTL-SDR devices, but you can list them yourself with

```
ls -al $(brew --prefix rtlsdr)/bin
ls -al $(brew --prefix hackrf)/bin
```

### A note about gqrx and the HackRF

gqrx will only show the HackRF if it's plugged in **before** you start gqrx. The device string should be automatically filled in, but if you need one, use `hackrf=0` to use the first detected HackRF device, `hackrf=1` for the second, and so on.

### A note about gqrx and no audio output

After you run gqrx for the first time, you might not get any audio. Before you panic that it's not working, make sure that you've:

* 'switched gqrx on' with the first button in the toolbar
* chosen a demodulator
* increased the audio gain and/or your system volume high enough

## Problems? Questions? Suggestions?

I can't promise that I'll keep this repo updated on my own. The good news is that I do use GitHub Issues. Open a ticket if you have any problems, or if you want the version bumped for any of these formulae. Bonus points if you accompany your ticket with a pull request.

Enjoy!

[rtrepo]: https://github.com/robotastic/homebrew-hackrf
[mcrepo]: https://github.com/metacollin/homebrew-gnuradio
[gnuradio]: https://gnuradio.org/redmine/projects/gnuradio/wiki
[grbaz]: http://wiki.spench.net/wiki/Gr-baz
[grosmosdr]: http://sdr.osmocom.org/trac/wiki/GrOsmoSDR
[xquartz]: http://xquartz.macosforge.org/trac/wiki
[gsgsdrcourse]: https://greatscottgadgets.com/sdr/
