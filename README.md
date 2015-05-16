# Mac SDR tools for HackRF and RTL-SDR

After the excellent prior work found at [robotastic/homebrew-hackrf][rtrepo] and [metacollin/homebrew-gnuradio][mcrepo], I decided to create a full suite of gnuradio-based tools targeting the 3.7.7.1 release of [GNU Radio][gnuradio].

Included are Homebrew formulae for -

* GNU Radio with GNU Radio Companion
* The gqrx general-purpose tuner
* RTL-SDR libraries and utilities
* 

prereqs:

* homebrew python already installed and happy
* Xquartz installed and rebooted

bottles use os x python which will not play nicely with the setup here. make sure gnuradio **and all of its dependencies** are built from source and not installed from bottles.

optional: in your shell config file (`.bashrc`, `.zshrc`, etc...), disable bottles entirely (and avoid having to type `--build-from-source` every time) with `export HOMEBREW_BUILD_FROM_SOURCE=1`

```sh
brew install --build-from-source libxml2 --with-python
brew install --build-from-source libxslt
brew link libxml2 --force
brew link libxslt --force
```

```sh
pip install Cheetah lxml matplotlib numpy scipy docutils sphinx
```

```sh
brew tap daveio/hackrf
```

```sh
brew install --build-from-source wxmac --python
brew install boost ---with-icu4c --build-from-source
```

```sh
brew install gnuradio
```

```sh
brew install --HEAD gr-baz
brew install --HEAD rtlsdr
brew install --build-from-source hackrf
brew install --HEAD gr-osmosdr
```

now we want gqrx

```sh
brew install --HEAD gqrx
```
gqrx will only show the hackrf if it's plugged in before you start gqrx. pick the hackrf in the device menu. if you need a device string, use `hackrf=0` to use the first detected hackrf device.

before you panic that it's not working and you're hearing no audio, make sure that you've

* switched gqrx 'on' with the first button in the toolbar
* chosen a demodulator
* increased the audio gain and/or your system volume enough

[rtrepo]: https://github.com/robotastic/homebrew-hackrf
[mcrepo]: https://github.com/metacollin/homebrew-gnuradio
[gnuradio]: https://gnuradio.org/redmine/projects/gnuradio/wiki