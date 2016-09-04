require 'formula'

class Uhd < Formula
  homepage 'http://www.ettus.com/'
  url 'https://github.com/EttusResearch/uhd/archive/release_003_010_000_000.tar.gz'
  sha256 '9e018c069851fd68ba63908a9f9944763832ce657f5b357d4e6c64293ad0d2cd'
  version '3.10.0'
  head 'https://github.com/EttusResearch/uhd.git',
    :revision => '6e1ac3fc9433642d02d7963ecfdd9aef3ca6d35e',
    :shallow => true

  depends_on 'cmake' => :build
  depends_on 'automake' => :build
  depends_on 'libusb'
  depends_on 'boost'

  def install
    cd "host"
    mkdir "build"
    cd "build"
    system "cmake","../","-DCMAKE_INSTALL_PREFIX=#{prefix}",*std_cmake_args
    # system "cmake", ".", *std_cmake_args
    system "make install" # if this fails, try separate make/make install steps
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test ettus-uhd`.
    system "false"
  end
end
