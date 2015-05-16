homebrew-gnuradio
=================

thanks to robotastic/homebrew-hackrf and metacollin/homebrew-gnuradio

prereqs:
  * homebrew python already installed and happy
  * Xquartz installed and rebooted

bottles use os x python
optional: in your shell config file, disable bottles with

```sh
export HOMEBREW_BUILD_FROM_SOURCE=1
```

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


