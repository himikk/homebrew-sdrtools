require 'formula'

class EttusUhd < Formula
  homepage 'http://www.ettus.com/'
  url 'https://github.com/EttusResearch/uhd/archive/release_003_008_004.tar.gz'
  sha1 'fe2ef0c56567482a1789797ba94490daeb98338d'
  version '3.7.3'
  head 'https://github.com/EttusResearch/uhd.git',
    :revision => '51bc00eed37b2bcc8c4d33b0093a7e3e573141a4',
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
