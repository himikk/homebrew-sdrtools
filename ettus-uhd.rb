require 'formula'

class EttusUhd < Formula
  homepage 'http://www.ettus.com/'
  url 'https://github.com/EttusResearch/uhd/archive/003_008_005_rc1.tar.gz'
  sha1 '15def4f7227b577fb56011e562e4f1081816fadb'
  version '3.8.5rc1'
  head 'https://github.com/EttusResearch/uhd.git',
    :revision => '012381d999c4a895593412aaf06e73432b458810',
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
